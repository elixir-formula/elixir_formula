defmodule Scrapers.Podcasts.Elixiroutlaws do
  @moduledoc """
  Elixiroutlaws.com podcasts scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://elixiroutlaws.com/"

  def article_source,
    do: "elixiroutlaws.com"

  def articles_selector,
    do: "ul.list.header > li"

  def article_url(article) do
    url =
      article
      |> Floki.find("h3 > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://elixiroutlaws.com" <> url
  end

  # single article processing

  def article_author(_article) do
    "elixiroutlaws"
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
    ["elixir", "podcast", "elixiroutlaws"]
  end
end
