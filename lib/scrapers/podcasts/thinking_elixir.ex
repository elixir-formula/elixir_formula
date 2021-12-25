defmodule Scrapers.Podcasts.ThinkingElixir do
  @moduledoc """
  Thinkingelixir.com podcasts scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://podcast.thinkingelixir.com/"

  def article_source,
    do: "thinkingelixir.com"

  def articles_selector,
    do: "ul.list.cover > li"

  def article_url(article) do
    url =
      article
      |> Floki.find("li > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "http://podcast.thinkingelixir.com" <> url
  end

  # single article processing

  def article_author(_article) do
    "Mark Ericksen"
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
    ["elixir", "podcast", "thinkingelixir"]
  end
end
