defmodule ElixirFormula.AdHoc.LoadDb do
  alias ElixirFormula.Publications.Schemas.Publication
  alias ElixirFormula.Repo

  def call do
    {:ok, response} = Finch.build(:get, resource()) |> Finch.request(ElixirFormula.Finch)

    response.body
    |> Jason.decode!()
    |> Enum.each(fn publication ->
      params =
        case Map.get(publication, "updated_at") do
          "" -> Map.put(publication, "inserted_at", ~U[2018-01-01 00:00:00Z])
          time_string ->  Map.put(publication, "inserted_at", Timex.parse!(time_string, "%Y-%m-%d %H:%M:%S %Z", :strftime))
        end
      Publication.changeset(%Publication{}, params) |> Repo.insert
    end)
  end

  def resource, do: "https://elixirjsonbucket.s3.eu-central-1.amazonaws.com/data.json"
end
