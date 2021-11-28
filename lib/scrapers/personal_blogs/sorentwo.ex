defmodule Scrapers.PersonalBlogs.Sorentwo do
  @moduledoc """
  Sorentwo.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://sorentwo.com/blog/"

  def article_source,
    do: "sorentwo.com"

  def articles_selector,
    do: "div.post-preview"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.post-title")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://sorentwo.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("span.author")
    |> Floki.text(sep: ",")
    |> String.split(",")
    |> Enum.at(1)
    |> String.trim()
  end

  def article_image_url(article) do
    image_url =
      article
      |> Floki.find("section.post-body > p > img")
      |> Floki.attribute("src")
      |> Floki.text()

    case image_url do
      "" ->
        "https://d32myzxfxyl12w.cloudfront.net/images/blog_images/1145e4a9d0a56c29e4eb3ffbdbaa0362299e8e8f.png?1540465745"

      image_url ->
        "https://sorentwo.com" <> image_url
    end
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
    ["elixir", "oban"]
  end
end
