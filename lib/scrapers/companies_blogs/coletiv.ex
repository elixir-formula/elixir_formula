defmodule Scrapers.CompaniesBlogs.Coletiv do
  @moduledoc """
  Coletiv.com scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://www.coletiv.com/blog/category/elixir/"

  def article_source,
    do: "coletiv.com"

  def articles_selector,
    do: "article[class^='BlogCard__Wrapper']"

  def article_url(article) do
    url =
      article
      |> Floki.find("h2 > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://www.coletiv.com" <> url
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("a[class^='BlogAuthor__AuthorName']")
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
    |> Floki.find("a[class^='TagsLinks']")
    |> Floki.text(sep: ",")
    |> String.downcase()
    |> String.split(",")
  end
end
