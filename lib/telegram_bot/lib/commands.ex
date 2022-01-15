defmodule TelegramBot.Commands do
  @moduledoc false

  alias ElixirFormula.Publications
  alias ElixirFormula.Votes

  def match_message(%{callback_query: %{id: callback_id, data: action, from: from, message: message}}) do
    with {:ok, publication} <- Publications.get_publication(:message_id, message.message_id) do
      Votes.voting(publication, String.to_existing_atom(action), from.id, callback_id)
    end
  end
end
