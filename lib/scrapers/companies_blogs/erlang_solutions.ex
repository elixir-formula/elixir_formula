defmodule Scrapers.CompaniesBlogs.ErlangSolutions do
  @moduledoc """
  Erlang-solutions.com scrapper implementation.
  """
  use Scrapers.Interface

  # articles processing

  def resource,
    do: "https://www.erlang-solutions.com/blog/"

  def article_source,
    do: "erlang-solutions.com"

  def articles_selector,
    do: "div.grid-card.col-sm-6.col-lg-4"

  def article_url(article) do
    article
    |> Floki.find("a.link-to-all")
    |> Floki.attribute("href")
    |> Floki.text()
  end

  # single article processing

  def article_author(article) do
    article
    |> Floki.find("div.post-info__author > a")
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
    |> Floki.find("a.category")
    |> Floki.text()
    |> String.downcase()
    |> List.wrap()
  end
end
