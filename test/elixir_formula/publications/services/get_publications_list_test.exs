defmodule ElixirFormula.Publications.Services.GetPublicationsListTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Publications.Services.GetPublicationsList

  setup do
    insert(:publication, status: "pending")
    insert(:publication, status: "published")

    :ok
  end

  describe "with filter by pending status" do
    test "returns list of pending publications" do
      assert %Scrivener.Page{entries: [%Publication{status: "published"}]} =
               GetPublicationsList.call(%{status: "published"})
    end
  end

  describe "without any filters" do
    test "returns list of all publications" do
      %Scrivener.Page{entries: publications} = GetPublicationsList.call(%{})
      assert Enum.count(publications) == 2
    end
  end
end
