defmodule Scrapers.PersonalBlogs.PhoenixFramework do
  @moduledoc """
  Phoenixframework.org scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://www.phoenixframework.org/blog"

  def article_source,
    do: "phoenixframework.org"

  def articles_selector,
    do: "div.card"

  def article_url(article) do
    url =
      article
      |> Floki.find("a.btn.half-button")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://www.phoenixframework.org" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("p.lead")
    |> Floki.text()
    |> String.split("by")
    |> Enum.at(1)
    |> String.trim()
  end

  def article_image_url(_article) do
    "https://d32myzxfxyl12w.cloudfront.net/images/blog_images/1145e4a9d0a56c29e4eb3ffbdbaa0362299e8e8f.png?1540465745"
  end

  def article_description(article) do
    article
    |> Floki.find("meta[name='description']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_title(article) do
    article
    |> Floki.find("h1.mt-4")
    |> Floki.text()
  end

  def article_tags(_article) do
    ["elixir", "phoenix"]
  end
end
