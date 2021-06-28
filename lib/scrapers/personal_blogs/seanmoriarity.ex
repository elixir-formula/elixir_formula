defmodule Scrapers.PersonalBlogs.Seanmoriarity do
  @moduledoc """
  Seanmoriarity.com scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://seanmoriarity.com/"

  def article_source,
    do: "seanmoriarity.com"

  def articles_selector,
    do: "article.post"

  def article_url(article) do
    article
    |> Floki.find("h1.entry-title > a")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(_article) do
    "Sean Moriarity"
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
    ["elixir", "ai"]
  end
end
