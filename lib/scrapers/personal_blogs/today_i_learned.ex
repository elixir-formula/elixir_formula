defmodule Scrapers.PersonalBlogs.TodayILearned do
  @moduledoc """
  Pentacent.org scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://til.hashrocket.com/elixir"

  def article_source,
    do: "til.hashrocket.com"

  def articles_selector,
    do: "article.post"

  def article_url(article) do
    url =
      article
      |> Floki.find("div.post__content.copy > h1 > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://til.hashrocket.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("p.byline > a")
    |> Floki.text()
  end

  def article_image_url(article) do
    article
    |> Floki.find("meta[name='twitter:image']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_description(article) do
    article
    |> Floki.find("meta[name='twitter:description']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_title(article) do
    article
    |> Floki.find("meta[name='twitter:title']")
    |> Floki.attribute("content")
    |> Floki.text()
  end

  def article_tags(_article) do
    ["elixir"]
  end
end
