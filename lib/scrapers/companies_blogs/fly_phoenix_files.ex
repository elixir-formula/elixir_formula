defmodule Scrapers.CompaniesBlogs.FlyPhoenixFiles do
  @moduledoc """
  Fly.io/phoenix-files/ scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://fly.io/phoenix-files/"

  def article_source,
    do: "fly.io/phoenix-files"

  def articles_selector,
    do: "article"

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
end
