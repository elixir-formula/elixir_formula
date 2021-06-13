defmodule Scrapers.CompaniesBlogs.Curiosum do
  @moduledoc """
  Curiosum.dev scrapper implementation.
  """
  use Scrapers.Interface

  def articles_selector,
    do: "article.blog-card"

  def article_author(article) do
    article
    |> Floki.find("div.blog-card__author-name")
    |> Floki.text()
    |> String.trim()
  end

  def article_title(article) do
    article
    |> Floki.find("h3.blog-card__title")
    |> Floki.text()
    |> String.trim()
  end

  def article_tags(_article) do
    ["elixir"]
  end

  def article_url(article) do
    url =
      article
      |> Floki.find("div.blog-card__content > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://curiosum.com" <> url
  end

  def article_source, do: "curiosum.com"

  def resource, do: "https://curiosum.com/blog/category/elixir"
end
