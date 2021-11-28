defmodule Scrapers.CompaniesBlogs.Smartlogic do
  @moduledoc """
  Smartlogic.io scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://smartlogic.io/blog/tag/elixir/"

  def article_source,
    do: "smartlogic.io"

  def articles_selector,
    do: "article.post-card"

  def article_url(article) do
    article
    |> Floki.find("a.permalink")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("a.author > span.name")
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
    |> Floki.find("div.col-md-offset-1.col-md-10 > span.category > a")
    |> Floki.text(sep: ",")
    |> String.downcase()
    |> String.split(",")
  end
end
