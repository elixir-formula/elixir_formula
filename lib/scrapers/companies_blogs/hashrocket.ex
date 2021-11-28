defmodule Scrapers.CompaniesBlogs.Hashrocket do
  @moduledoc """
  Hashrocket.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://hashrocket.com/blog/tags/elixir"

  def article_source,
    do: "hashrocket.com"

  def articles_selector,
    do: "article > ul > li"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.image")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://hashrocket.com" <> url
  end

  # single article processing

  def article_author(article) do
    case Floki.find(article, "a.author") do
      [] -> do_article_author(article)
      author -> Floki.text(author)
    end
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
    |> Floki.find("div.blog-post__header > h3 > a.category_flag")
    |> Floki.text(sep: ",")
    |> String.downcase()
    |> String.split(",")
  end

  defp do_article_author(article) do
    article
    |> Floki.find("a.author, p.byline")
    |> Floki.text()
    |> String.split("\n", trim: true)
    |> Enum.at(1)
  end
end
