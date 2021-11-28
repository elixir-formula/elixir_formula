defmodule Scrapers.CompaniesBlogs.AppSignal do
  @moduledoc """
  AppSignal.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://blog.appsignal.com/category/elixir.html"

  def article_source,
    do: "appsignal.com"

  def articles_selector,
    do: "article.mod-preview"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.opacity_6")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://blog.appsignal.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("p.meta")
    |> Floki.text()
    |> String.trim()
    |> String.split("\n")
    |> hd()
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
