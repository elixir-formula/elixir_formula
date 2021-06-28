defmodule Scrapers.Podcasts.ThinkingElixir do
  @moduledoc """
  Thinkingelixir.com podcasts scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://thinkingelixir.com/the-podcast/"

  def article_source,
    do: "thinkingelixir.com"

  def articles_selector,
    do: "div.fl-post-grid-post"

  def article_url(article) do
    article
    |> Floki.find("h2.fl-post-grid-title > a")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(article) do
    "Mark Ericksen"
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
    ["elixir", "podcast", "thinkingelixir"]
  end
end
