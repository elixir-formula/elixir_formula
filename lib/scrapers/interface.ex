defmodule Scrapers.Interface do
  @moduledoc """
  Defines the contract to implement different html scrapers.
  """

  @callback article_author(article :: tuple()) :: binary()
  @callback article_title(article :: tuple()) :: binary()
  @callback article_description(article :: tuple()) :: binary()
  @callback article_image_url(article :: tuple()) :: binary()
  @callback article_tags(article :: tuple()) :: list()
  @callback article_url(article :: tuple()) :: binary()
  @callback article_source() :: binary()
  @callback resource() :: binary()

  defmacro __using__([]) do
    quote do
      @behaviour Scrapers.Interface

      use GenServer

      alias ElixirFormula.{Monitoring, Publications}

      @interval 3_600_000

      # API

      def start_link(arg) do
        GenServer.start_link(__MODULE__, %{interval: @interval}, name: __MODULE__)
      end

      # Callbacks

      def init(%{interval: interval} = state) do
        :erlang.send_after(interval, self(), :process_resource)
        {:ok, state}
      end

      def handle_info(:process_resource, %{interval: interval} = state) do
        resource()
        |> create_request()
        |> parse_html()
        |> get_articles()
        |> update_status()
        |> Enum.each(&process_article/1)

        :erlang.send_after(interval, self(), :process_resource)
        {:noreply, state}
      end

      # Processing

      def create_request(resource),
        do: Finch.build(:get, resource) |> Finch.request(ElixirFormula.Finch)

      def parse_html({:ok, response}),
        do: Floki.parse_document(response.body)

      def get_articles({:ok, document}),
        do: Floki.find(document, articles_selector())

      def process_article(article) do
        article
        |> post_url()
        |> create_request()
        |> parse_html()
        |> build_params()
        |> Publications.create_publication()
      end

      def update_status([] = articles) do
        with {:ok, scraper_status} <- Monitoring.get_scraper_status(:source, article_source()),
             {:ok, _} <-
               Monitoring.update_scraper_status(scraper_status, %{
                 status: :inactive,
                 jobs_count: scraper_status.jobs_count + 1
               }) do
          articles
        end
      end

      def update_status(articles) do
        with {:ok, scraper_status} <- Monitoring.get_scraper_status(:source, article_source()),
             {:ok, _} <-
               Monitoring.update_scraper_status(scraper_status, %{
                 status: :active,
                 jobs_count: scraper_status.jobs_count + 1
               }) do
          articles
        end
      end

      def build_params({:ok, article}) do
        %{
          title: article_title(article),
          url: article_url(article),
          description: article_description(article),
          image_url: article_image_url(article),
          tags: article_tags(article),
          author_name: article_author(article),
          source: article_source()
        }
      end
    end
  end
end
