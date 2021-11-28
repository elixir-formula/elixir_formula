defmodule Scrapers.CompaniesBlogs.Thoughtbot do
  @moduledoc """
  Thoughtbot.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://thoughtbot.com/blog/tags/elixir"

  def article_source,
    do: "thoughtbot.com"

  def articles_selector,
    do: "li.mini-post"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.mini-post-link")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://thoughtbot.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("div.meta-author > a")
    |> Floki.text()
  end

  def article_image_url(_article) do
    "https://d32myzxfxyl12w.cloudfront.net/images/blog_images/1145e4a9d0a56c29e4eb3ffbdbaa0362299e8e8f.png?1540465745"
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
    |> Floki.find("li.meta-tag-item")
    |> Floki.text(sep: ",")
    |> String.split(",")
  end
end
