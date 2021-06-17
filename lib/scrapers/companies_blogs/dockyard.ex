defmodule Scrapers.CompaniesBlogs.Dockyard do
  @moduledoc """
  Dockyard.com scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://dockyard.com/blog/categories/elixir"

  def article_source,
    do: "dockyard.com"

  def articles_selector,
    do: "div.blog-post__content--latest, li.blog-post-sample"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.blog-post__link--latest, a.blog-post__link")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://dockyard.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("span.blog-post__meta-author")
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
    |> Floki.find("li.blog-category-list__item")
    |> Floki.text()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(byte_size(&1) != 0))
  end
end
