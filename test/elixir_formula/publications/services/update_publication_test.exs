defmodule ElixirFormula.Publications.Services.UpdatePublicationTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Publications.Services.UpdatePublication

  setup do
    publication = insert(:publication)

    [publication: publication]
  end

  describe "with valid params" do
    test "returns {:ok, %Publication{}}", %{publication: publication} do
      assert {:ok, publication} = UpdatePublication.call(publication, %{status: :rejected})
      assert publication.status == :rejected
    end
  end

  describe "with invalid params" do
    test "returns {:error, %Ecto.Changeset{}}", %{publication: publication} do
      assert {:error, changeset} = UpdatePublication.call(publication, %{title: ""})
      assert %{title: ["can't be blank"]} == errors_on(changeset)
    end
  end
end
