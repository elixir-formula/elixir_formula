defmodule TelegramBot do
  @moduledoc false

  use Supervisor

  def start_link(_init) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      TelegramBot.Poller,
      TelegramBot.Matcher
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
