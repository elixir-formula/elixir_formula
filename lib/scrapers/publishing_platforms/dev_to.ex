defmodule Scrapers.PublishingPlatforms.DevTo do
  @moduledoc """
  Dev.to scrapper implementation.
  """
  use Scrapers.Interface

  def articles_selector,
    do: "div.crayons-story"

  def article_author(article) do
    article
    |> Floki.find("p > a.crayons-story__secondary.fw-medium")
    |> Floki.text()
    |> String.trim()
  end

  def article_title(article) do
    article
    |> Floki.find("h2.crayons-story__title")
    |> Floki.text()
    |> String.trim()
  end

  def article_tags(article) do
    article
    |> Floki.find("a.crayons-tag")
    |> Floki.text()
    |> String.split("#", trim: true)
  end

  def article_url(article) do
    url =
      article
      |> Floki.find("h2.crayons-story__title > a")
      |> Floki.attribute("href")
      |> Floki.text()

    "https://dev.to" <> url
  end

  def article_source, do: "dev.to"

  def resource, do: "https://dev.to/t/elixir/latest"
end
