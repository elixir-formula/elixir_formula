defmodule Scrapers.PersonalBlogs.Angelika do
  @moduledoc """
  Angelika.me scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://angelika.me/blog/"

  def article_source,
    do: "angelika.me"

  def articles_selector,
    do: "article.post-preview"

  def article_url(article) do
    url =
      article
      |> Floki.find("h2 > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://angelika.me" <> url
  end

  # single article processing

  def article_author(_article) do
    "Angelika Tyborska"
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
    |> Floki.find("span.tags > a")
    |> Floki.text(sep: ",")
    |> String.downcase()
    |> String.split(",")
  end
end
