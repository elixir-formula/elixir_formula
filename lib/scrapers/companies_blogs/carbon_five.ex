defmodule Scrapers.CompaniesBlogs.CarbonFive do
  @moduledoc """
  CarbonFive.com scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://blog.carbonfive.com/category/elixir/"

  def article_source,
    do: "carbonfive.com"

  def articles_selector,
    do: "div.columns > div.column > div.card"

  def article_url(article) do
    article
    |> Floki.find("div.card-content > a")
    |> Floki.attribute("href")
    |> Enum.reverse()
    |> hd()
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("p.has-margin-bottom-20 > a")
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
    |> Floki.find("div.level-left > a")
    |> Floki.text(sep: " ")
    |> String.split(" ")
  end
end
