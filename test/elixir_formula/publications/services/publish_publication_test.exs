defmodule ElixirFormula.Publications.Services.PublishPublicationTest do
  use ElixirFormula.DataCase

  import Mock

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Publications.Services.PublishPublication
  alias ElixirFormula.Repo

  setup do
    publication = insert(:publication, status: :pending)

    [publication: publication]
  end

  test "returns {:ok, message}", %{publication: publication} do
    with_mock Nadia, send_message: fn _, _, _ -> {:ok, %Nadia.Model.Message{}} end do
      assert {:ok, _message} = PublishPublication.call(publication)
      assert %Publication{status: :published} = Repo.get(Publication, publication.id)
    end
  end
end
