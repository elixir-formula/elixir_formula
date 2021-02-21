defmodule ElixirFormula.Publications.CreateTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.{Publications, Publication}

  setup do
    publication = insert(:publication, title: "elixir", author_name: "lady gaga")

    base_params = %{
      "title" => "Elixir article",
      "url" => "http://dev.to/elixir-article",
      "author_name" => "Lady Gaga",
      "source" => "dev.to"
    }

    [base_params: base_params, publication: publication]
  end

  describe "when publication doesn't exist" do
    test "returns {:ok, %Publication{}}", %{base_params: base_params, publication: publication} do
      assert {:ok, %Publication{} = new_publication} = Publications.Create.call(base_params)
      assert new_publication.id != publication.id
    end
  end

  describe "when params is invalid" do
    test "returns {:error, %Ecto.Changeset{}}", %{base_params: base_params} do
      base_params = Map.merge(base_params, %{"title" => ""})
      assert {:error, _changeset} = Publications.Create.call(base_params)
    end
  end

  describe "when publication already exists" do
    test "returns {:ok, nil}", %{base_params: base_params} do
      base_params = Map.merge(base_params, %{"title" => "elixir", "author_name" => "lady gaga"})
      assert {:ok, nil} = Publications.Create.call(base_params)
    end
  end
end
