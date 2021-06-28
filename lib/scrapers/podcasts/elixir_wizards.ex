defmodule Scrapers.Podcasts.ElixirWizards do
  @moduledoc """
  Smartlogic.io podcasts scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://smartlogic.io/podcast/elixir-wizards/"

  def article_source,
    do: "elixir_wizards"

  def articles_selector,
    do: "article.casestudies-horizontal__article"

  def article_url(article) do
    url =
      article
      |> Floki.find("p > a")
      |> Floki.attribute("href")
      |> Floki.text()
      |> Kernel.<>("/")

    "https://smartlogic.io" <> url
  end

  # single article processing

  def article_author(_article) do
    "elixir_wizards"
  end

  def article_image_url(article) do
    article
    |> Floki.find("meta[property='og:image']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_description(article) do
    article
    |> Floki.find("meta[property='og:description']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_title(article) do
    article
    |> Floki.find("meta[property='og:title']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_tags(_article) do
    ["elixir", "podcast", "elixir_wizards"]
  end
end
