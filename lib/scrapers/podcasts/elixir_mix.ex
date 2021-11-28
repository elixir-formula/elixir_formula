defmodule Scrapers.Podcasts.ElixirMix do
  @moduledoc """
  ElixirMix podcasts scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://elixirmix.com/"

  def article_source,
    do: "elixir_mix"

  def articles_selector,
    do: "ul.list.cover > li"

  def article_url(article) do
    url =
      article
      |> Floki.find("h2.secondline-blog-title > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://elixirmix.com" <> url
  end

  # single article processing

  def article_author(_article) do
    "elixir_mix"
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
    ["elixir", "podcast", "elixir_mix"]
  end
end
