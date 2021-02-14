defmodule Scrapers.Interface do
  @moduledoc """
  Defines the contract to implement different html scrapers.
  """

  @callback article_author(article :: tuple()) :: binary()
  @callback article_title(article :: tuple()) :: binary()
  @callback article_tags(article :: tuple()) :: list()
  @callback article_url(article :: tuple()) :: binary()
  @callback article_source() :: binary()
  @callback resource() :: binary()

  defmacro __using__([]) do
    quote do
      @behaviour Scrapers.Interface

      use GenServer

      alias ElixirFormula.Publications

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
        |> Enum.each(&process_article/1)

        :erlang.send_after(interval, self(), :process_resource)
        {:noreply, state}
      end

      # Processing

      def create_request(resource),
        do: HTTPoison.get(resource)

      def parse_html({:ok, response}),
        do: Floki.parse_document(response.body)

      def get_articles({:ok, document}),
        do: Floki.find(document, "div.crayons-story")

      def process_article(article) do
        article
        |> build_params()
        |> Publications.create_publication()
      end

      def build_params(article) do
        %{
          "title" => article_title(article),
          "url" => article_url(article),
          "tags" => article_tags(article),
          "author_name" => article_author(article),
          "source" => article_source()
        }
      end
    end
  end
end
