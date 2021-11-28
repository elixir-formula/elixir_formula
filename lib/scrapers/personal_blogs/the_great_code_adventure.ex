defmodule Scrapers.PersonalBlogs.TheGreatCodeAdventure do
  @moduledoc """
  The Great Code Adventure scraper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://www.thegreatcodeadventure.com/"

  def article_source,
    do: "thegreatcodeadventure.com"

  def articles_selector,
    do: "article.post"

  def article_url(article) do
    url =
      article
      |> Floki.find("h2.post-title > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://www.thegreatcodeadventure.com" <> url
  end

  # single article processing

  def article_author(_article) do
    "Sophie DeBenedetto"
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
    |> Floki.find("span.post-meta > a")
    |> Floki.text(sep: ",")
    |> String.split(",")
    |> Enum.map(&String.replace(&1, " ", "_"))
  end
end
