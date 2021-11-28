defmodule Scrapers.CompaniesBlogs.Serokell do
  @moduledoc """
  Serokell.io scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://serokell.io/blog/elixir"

  def article_source,
    do: "serokell.io"

  def articles_selector,
    do: "div.blog__post"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.blog__post-title")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://serokell.io" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("div.blog__authors-names > a")
    |> Floki.text()
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
    |> Floki.find("div.blog-post__footer-tags > a")
    |> Floki.text(sep: ",")
    |> String.split(",")
  end
end
