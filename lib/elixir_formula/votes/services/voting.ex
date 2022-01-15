defmodule ElixirFormula.Votes.Services.Voting do
  @moduledoc false

  use ElixirFormula.Votes.InlineKeyboardMarkup

  alias ElixirFormula.Publications
  alias ElixirFormula.Publications.Schemas.Publication

  @spec call(Publication.t(), atom(), integer(), binary()) :: {:ok, map()}
  def call(publication, telegram_action, user_id, callback_id) do
    with action <- get_action(publication, telegram_action, user_id),
         {:ok, publication} <- update_publication(action, telegram_action, publication, user_id),
         {likes_count, dislikes_count} <- calculate_likes_dislikes(publication),
         :ok <- answer_callback_query(action, telegram_action, callback_id) do
      edit_inline_keybord(publication.message_id, likes_count, dislikes_count)
    end
  end

  defp answer_callback_query(:new_vote, :like, callback_id) do
    Nadia.answer_callback_query(callback_id, text: "You 👍 this.")
  end

  defp answer_callback_query(:new_vote, :dislike, callback_id) do
    Nadia.answer_callback_query(callback_id, text: "You 👎 this.")
  end

  defp answer_callback_query(:withdraw, _, callback_id) do
    Nadia.answer_callback_query(callback_id, text: "You took your reaction back.")
  end

  defp calculate_likes_dislikes(%{like_users: like_users, dislike_users: dislike_users}) do
    {Enum.count(like_users), Enum.count(dislike_users)}
  end

  defp channel_id,
    do: Application.fetch_env!(:nadia, :channel_id)

  defp edit_inline_keybord(message_id, likes_count, dislikes_count) do
    Nadia.edit_message_reply_markup(channel_id(), message_id, nil,
      reply_markup: reply_markup(likes_count, dislikes_count)
    )
  end

  defp get_action(publication, :like, user_id) do
    if Enum.member?(publication.like_users, user_id), do: :withdraw, else: :new_vote
  end

  defp get_action(publication, :dislike, user_id) do
    if Enum.member?(publication.dislike_users, user_id), do: :withdraw, else: :new_vote
  end

  defp update_publication(:new_vote, :like, publication, user_id) do
    with like_users <- [user_id | publication.like_users] do
      Publications.update_publication(publication, %{like_users: like_users})
    end
  end

  defp update_publication(:new_vote, :dislike, publication, user_id) do
    with dislike_users <- [user_id | publication.dislike_users] do
      Publications.update_publication(publication, %{dislike_users: dislike_users})
    end
  end

  defp update_publication(:withdraw, :like, publication, user_id) do
    with like_users <- List.delete(publication.like_users, user_id) do
      Publications.update_publication(publication, %{like_users: like_users})
    end
  end

  defp update_publication(:withdraw, :dislike, publication, user_id) do
    with dislike_users <- List.delete(publication.dislike_users, user_id) do
      Publications.update_publication(publication, %{dislike_users: dislike_users})
    end
  end
end
