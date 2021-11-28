defmodule Scrapers.PersonalBlogs.Pentacent do
  @moduledoc """
  Pentacent.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://pentacent.com/blog/"

  def article_source,
    do: "pentacent.com"

  def articles_selector,
    do: "div.snippet"

  def article_url(article) do
    url =
      article
      |> Floki.find("h3.title > a")
      |> Floki.attribute("href")
      |> Floki.text()
      |> Kernel.<>("/")

    "https://pentacent.com" <> url
  end

  # single article processing

  def article_author(_article) do
    "pentacent"
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
