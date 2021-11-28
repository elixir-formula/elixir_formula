defmodule Scrapers.CompaniesBlogs.AppUnite do
  @moduledoc """
  AppUnite.com scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://appunite.com/blog/tag/elixir"

  def article_source,
    do: "appunite.com"

  def articles_selector,
    do: "a.PostCard_post__P_m3b"

  def article_url(article) do
    url =
      article
      |> Floki.attribute("href")
      |> Floki.text()

    "https://appunite.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("p.Author_authorName__3Pira")
    |> hd()
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
    |> Floki.find("div.PostBottomTags_tag__2eVh3 > a")
    |> Floki.text(sep: ",")
    |> String.downcase()
    |> String.split(",")
  end
end
