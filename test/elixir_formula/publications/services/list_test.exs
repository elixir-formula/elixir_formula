defmodule ElixirFormula.Publications.ListTest do
  use ElixirFormula.DataCase, async: true

  alias ElixirFormula.{Publications, Publication}

  setup do
    insert(:publication, status: "pending")
    insert(:publication, status: "published")

    :ok
  end

  describe "with filter by pending status" do
    test "returns list of pending publications" do
      assert [%Publication{status: "published"}] = Publications.List.call(%{"status" => "published"})
    end
  end

  describe "without any filters" do
    test "returns list of all publications" do
      assert publications = Publications.List.call(%{})
      assert Enum.count(publications) == 2
    end
  end
end
