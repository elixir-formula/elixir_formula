defmodule ElixirFormula.Publications.Schemas.PublicationTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Publications.Schemas.Publication

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
    test "returns valid changeset", %{base_params: base_params} do
      changeset = Publication.create_changeset(%Publication{}, base_params)

      assert errors_on(changeset) == %{}
    end

    test "returns invalid chaangeset, when title isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{title: nil})
      changeset = Publication.create_changeset(%Publication{}, invalid_params)

      assert errors_on(changeset) == %{title: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when url isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{url: nil})
      changeset = Publication.create_changeset(%Publication{}, invalid_params)

      assert errors_on(changeset) == %{url: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when author_name isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{author_name: nil})
      changeset = Publication.create_changeset(%Publication{}, invalid_params)

      assert errors_on(changeset) == %{author_name: ["can't be blank"]}
    end

    test "returns invalid chaangeset, when source isn't present", %{base_params: base_params} do
      invalid_params = Map.merge(base_params, %{source: nil})
      changeset = Publication.create_changeset(%Publication{}, invalid_params)

      assert errors_on(changeset) == %{source: ["can't be blank"]}
    end
  end
end
