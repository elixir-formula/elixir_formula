defmodule Scrapers.CompaniesBlogs.Dashbit do
  @moduledoc """
  Dashbit.co scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://dashbit.co/blog"

  def article_source,
    do: "dashbit.co"

  def articles_selector,
    do: "div.blog"

  def article_url(article) do
    url =
      article
      |> Floki.find("h1 > a.text-dark")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://dashbit.co" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("li.user")
    |> Floki.text()
    |> String.trim()
  end

  def article_image_url(article) do
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
    |> Floki.find("article > h1")
    |> Floki.text()
  end

  def article_tags(article) do
    article
    |> Floki.find("li.date > a.text-primary")
    |> Floki.text(sep: " ")
    |> String.split(" ")
  end
end
