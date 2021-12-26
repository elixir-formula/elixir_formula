defmodule Scrapers.CompaniesBlogs.Betterdoc do
  @moduledoc """
  Betterdoc.org scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://dev.betterdoc.org/"

  def article_source,
    do: "betterdoc.org"

  def articles_selector,
    do: "ul.post-list > li"

  def article_url(article) do
    url =
      article
      |> Floki.find("h1 > a.post-link")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://dev.betterdoc.org" <> url
  end

  # single article processing

  def article_author(_article) do
    "dev.betterdoc.org"
  end

  def article_image_url(article) do
    article
    |> Floki.find("meta[name='og:image']")
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
