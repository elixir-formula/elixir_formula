defmodule Scrapers.CompaniesBlogs.Curiosum do
  @moduledoc """
  Curiosum.dev scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://curiosum.com/blog/category/elixir"

  def article_source,
    do: "curiosum.com"

  def articles_selector,
    do: "article.blog-card"

  def post_url(article) do
    url =
      article
      |> Floki.find("div.blog-card__content > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://curiosum.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("div.blog-card__author-name")
    |> hd()
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

  def article_tags(_article) do
    ["elixir"]
  end

  def article_url(article) do
    article
    |> Floki.find("meta[property='og:url']")
    |> Floki.attribute("content")
    |> Floki.text()
  end
end
