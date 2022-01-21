defmodule ElixirFormula.Publications.Services.SendPublication do
  @moduledoc false

  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Publications.Services.UpdatePublication

  @doc """
  Updates publication status to published and send message to the telegram channel.

  ## Examples

      iex> SendPublication.call(publication)
      :ok
  """
  @spec call(Publication.t()) :: {:ok, Nadia.Model.Message.t()}
  def call(publication) do
    with message <- build_message(publication),
         opts <- [parse_mode: "HTML", reply_markup: reply_markup()],
         {:ok, %{message_id: message_id}} <- Nadia.send_message(telegram_channel_id(), message, opts) do
      UpdatePublication.call(publication, %{status: :published, message_id: message_id})
    end
  end

  defp build_message(publication) do
    publication.tags
    |> Enum.reduce("", fn tag, acc -> "#{acc} ##{tag}" end)
    |> String.trim()
    |> Kernel.<>("\n\n<b>#{publication.title}</b> \n\n#{publication.url}")
  end

  defp reply_markup do
    %Nadia.Model.InlineKeyboardMarkup{
      inline_keyboard: [
        [%{text: "👍", callback_data: "like"}, %{text: "👎", callback_data: "dislike"}]
      ]
    }
  end

  defp telegram_channel_id, do: Application.fetch_env!(:nadia, :channel_id)
end
