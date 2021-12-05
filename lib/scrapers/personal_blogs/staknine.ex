defmodule Scrapers.PersonalBlogs.Staknine do
  @moduledoc """
  Staknine.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://staknine.com/"

  def article_source,
    do: "staknine.com"

  def articles_selector,
    do: "article.post"

  def article_url(article) do
    article
    |> Floki.find("h2.entry-title > a")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(article) do
    "StakNine"
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
    |> Floki.find("span.cat-links > a")
    |> Floki.text()
    |> List.wrap()
  end
end
