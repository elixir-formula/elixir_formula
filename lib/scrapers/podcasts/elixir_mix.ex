defmodule Scrapers.Podcasts.ElixirMix do
  @moduledoc """
  ElixirMix podcasts scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://devchat.tv/elixir-mix/"

  def article_source,
    do: "elixir_mix"

  def articles_selector,
    do: "div.secondline-masonry-padding-blog"

  def article_url(article) do
    article
    |> Floki.find("h2.secondline-blog-title > a")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("span.blog-meta-author-display > a")
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

  def article_tags(_article) do
    ["elixir", "podcast", "elixir_mix"]
  end
end
