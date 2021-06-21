defmodule ElixirFormula.Publications.Services.PublishPublication do
  @moduledoc false
  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Publications.Services.UpdatePublication

  @telegram_channel_id "-1001270913271"

  @doc """
  Updates publication status to published and send message to the telegram channel.

  ## Examples

      iex> PublishPublication.call(publication)
      :ok
  """
  @spec call(Publication.t()) :: {:ok, Nadia.Model.Message.t()}
  def call(publication) do
    with {:ok, publication} <- UpdatePublication.call(publication, %{status: :published}),
         message <- build_message(publication) do
      Nadia.send_message(@telegram_channel_id, message, parse_mode: "HTML")
    end
  end

  defp build_message(publication) do
    publication.tags
    |> Enum.reduce("", fn tag, acc -> "#{acc} ##{tag}" end)
    |> String.trim()
    |> Kernel.<>("\n\n<b>#{publication.title}</b>\n\n#{publication.url}")
  end
end
