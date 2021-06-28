defmodule Scrapers.CompaniesBlogs.Fly do
  @moduledoc """
  Fly.io scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://fly.io/blog/"

  def article_source,
    do: "fly.io"

  def articles_selector,
    do: "article.items-start"

  def article_url(article) do
    url =
      article
      |> Floki.find("a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://fly.io" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("dl.text-sm > dd.text-navy")
    |> Floki.text()
    |> String.trim()
  end

  def article_image_url(article) do
    article
    |> Floki.find("meta[name='twitter:image']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_description(article) do
    article
    |> Floki.find("div.lead")
    |> Floki.text()
    |> String.trim()
  end

  def article_title(article) do
    article
    |> Floki.find("meta[name='twitter:title']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_tags(_article) do
    ["elixir"]
  end
end
