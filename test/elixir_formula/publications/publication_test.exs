defmodule ElixirFormula.PublicationTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.{Publication, Repo}

  setup do
    base_params = %{
      title: "Elixir article",
      url: "http://dev.to/elixir-article",
      author_name: "Lady Gaga",
      source: "dev.to"
    }

    [base_params: base_params]
  end

  describe "create_changeset/2" do
    test "success case", %{base_params: base_params} do
      changeset = Publication.create_changeset(%Publication{}, base_params)
      assert %{} == errors_on(changeset)
    end
  end
end
