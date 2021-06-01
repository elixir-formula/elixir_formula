defmodule ElixirFormula.Publications.Services.GetPublicationTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Publications.Services.GetPublication

  describe "when searching by id" do
    test "returns {:ok, %Publication{}} when publication exists" do
      publication = insert(:publication)

      assert {:ok, found_publication} = GetPublication.call(:id, publication.id)
      assert found_publication.id == publication.id
    end

    test "returns error when publication doesn't exist" do
      assert {:error, :publication_not_found} = GetPublication.call(:id, 0)
    end
  end
end
