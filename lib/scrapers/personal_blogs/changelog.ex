defmodule Scrapers.PersonalBlogs.Changelog do
  @moduledoc """
  Changelog.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://changelog.com/topic/elixir/podcasts#feed"

  def article_source,
    do: "changelog.com"

  def articles_selector,
    do: "article.news_item"

  def article_url(article) do
    article
    |> Floki.find("h2.news_item-title > a")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(_article) do
    "changelog"
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
    |> Floki.find("li.tags-item")
    |> Floki.text(sep: ",")
    |> String.split(",")
  end
end
