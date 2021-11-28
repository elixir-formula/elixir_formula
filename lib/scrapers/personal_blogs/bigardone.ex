defmodule Scrapers.PersonalBlogs.Bigargone do
  @moduledoc """
  Bigargone.dev scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://bigardone.dev/blog"

  def article_source,
    do: "bigardone.dev"

  def articles_selector,
    do: "article.post-card"

  def article_url(article) do
    url =
      article
      |> Floki.find("a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://bigardone.dev" <> url
  end

  # single article processing

  def article_author(_article) do
    "bigardone"
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
    |> Floki.find("div.p-2.mb-2.mr-2.bg-gray-100.rounded-md")
    |> Floki.text(sep: ",")
    |> String.split(",")
  end
end
