defmodule Scrapers.PersonalBlogs.ElixirLang do
  @moduledoc """
  elixir-lang.org scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://elixir-lang.org/blog/"

  def article_source,
    do: "elixir-lang.org"

  def articles_selector,
    do: "div.hentry.post"

  def article_url(article) do
    url =
      article
      |> Floki.find("h2.entry-title > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://elixir-lang.org" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("meta[name='author']")
    |> Floki.attribute("content")
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
    |> Floki.find("a.category")
    |> Floki.text()
    |> String.downcase()
    |> String.split(" ")
    |> Enum.join("_")
    |> List.wrap()
  end
end
