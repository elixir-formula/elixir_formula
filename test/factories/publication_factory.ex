defmodule ElixirFormula.PublicationFactory do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def publication_factory do
        %ElixirFormula.Publications.Schemas.Publication{
          title: sequence(:name, &"Publication #{&1}"),
          url: "http://johndoe.medium.com/elixit-is-awesome",
          tags: ["elixir", "tutorial"],
          author_name: "John Doe",
          status: :pending,
          source: "medium"
        }
      end
    end
  end
end
