defmodule TelegramBot.Matcher do
  @moduledoc """
  This module matches incoming messages.
  """

  use GenServer, restart: :transient

  # Server

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, 0}
  end

  def handle_cast(message, state) do
    TelegramBot.Commands.match_message(message)

    {:noreply, state}
  end

  # Client

  def match(message) do
    GenServer.cast(__MODULE__, message)
  end
end
