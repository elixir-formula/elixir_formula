defmodule Scrapers.Podcasts.Beamrad do
  @moduledoc """
  Beamrad.io podcasts scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://www.beamrad.io/"

  def article_source,
    do: "beamrad.io"

  def articles_selector,
    do: "ul.list.header > li"

  def article_url(article) do
    url =
      article
      |> Floki.find("h3 > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://www.beamrad.io" <> url
  end

  # single article processing

  def article_author(_article) do
    "beamrad"
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
    ["elixir", "podcast", "beamrad"]
  end
end
