defmodule Scrapers.PublishingPlatforms.DevTo do
  @moduledoc """
  Dev.to scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://dev.to/t/elixir/latest"

  def article_source,
    do: "dev.to"

  def articles_selector,
    do: "div.crayons-story"

  def article_url(article) do
    url =
      article
      |> Floki.find("h2.crayons-story__title > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://dev.to" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("div.crayons-article__subheader > a")
    |> Floki.text()
    |> String.trim()
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

  def article_tags(article) do
    article
    |> Floki.find("a.crayons-tag")
    |> Floki.text()
    |> String.split("#", trim: true)
  end
end
