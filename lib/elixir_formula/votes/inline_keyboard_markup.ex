defmodule ElixirFormula.Votes.InlineKeyboardMarkup do
  @moduledoc false

  defmacro __using__([]) do
    quote do
      defp reply_markup(0, 0) do
        %Nadia.Model.InlineKeyboardMarkup{
          inline_keyboard: [[%{text: "👍", callback_data: "like"}, %{text: "👎", callback_data: "dislike"}]]
        }
      end

      defp reply_markup(likes_count, 0) do
        %Nadia.Model.InlineKeyboardMarkup{
          inline_keyboard: [
            [%{text: "👍 #{likes_count}", callback_data: "like"}, %{text: "👎", callback_data: "dislike"}]
          ]
        }
      end

      defp reply_markup(0, dislikes_count) do
        %Nadia.Model.InlineKeyboardMarkup{
          inline_keyboard: [
            [%{text: "👍", callback_data: "like"}, %{text: "👎 #{dislikes_count}", callback_data: "dislike"}]
          ]
        }
      end

      defp reply_markup(likes_count, dislikes_count) do
        %Nadia.Model.InlineKeyboardMarkup{
          inline_keyboard: [
            [
              %{text: "👍 #{likes_count}", callback_data: "like"},
              %{text: "👎 #{dislikes_count}", callback_data: "dislike"}
            ]
          ]
        }
      end
    end
  end
end
