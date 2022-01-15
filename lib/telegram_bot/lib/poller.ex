defmodule TelegramBot.Poller do
  @moduledoc """
  This module uses long polling to retrieve the last updates.
  offset - Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers
           of previously received updates. By default, updates starting with the earliest unconfirmed update are returned.
           An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id.
           The negative offset can be specified to retrieve updates starting from -offset update from the end of the
           updates queue. All previous updates will forgotten.
  """

  use GenServer, restart: :transient

  # Server

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, 0, {:continue, :update}}
  end

  def handle_continue(:update, offset) do
    update()

    {:noreply, offset}
  end

  def handle_cast(:update, offset) do
    {:ok, new_offset} =
      %{offset: offset}
      |> Nadia.get_updates()
      |> process_messages

    {:noreply, new_offset + 1, 100}
  end

  def handle_info(:timeout, offset) do
    update()

    {:noreply, offset}
  end

  # Client

  def update do
    GenServer.cast(__MODULE__, :update)
  end

  # Helpers

  defp process_messages({:ok, []}), do: {:ok, 0}
  defp process_messages({:ok, results}), do: process_messages(results, 0)
  defp process_messages({:error, _error}), do: {:ok, 0}

  defp process_messages([], acc), do: {:ok, acc}

  defp process_messages([%{update_id: offset} = message | tail], acc) do
    process_message(message)
    process_messages(tail, Enum.max([acc, offset]))
  end

  defp process_message(nil), do: nil
  defp process_message(message), do: TelegramBot.Matcher.match(message)
end
