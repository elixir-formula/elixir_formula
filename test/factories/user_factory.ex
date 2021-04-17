defmodule ElixirFormula.UserFactory do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %ElixirFormula.Users.Schemas.User{
          name: sequence(:name, &"User #{&1}"),
          email: sequence(:email, &"user_#{&1}@gmail.com"),
          nickname: sequence(:nickname, &"nickname_#{&1}"),
          image: "https://i.imgur.com/nnbRwDs.jpeg",
          location: "John Doe"
        }
      end
    end
  end
end
