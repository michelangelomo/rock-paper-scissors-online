defmodule Rps.Round do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rounds" do
    field :num, :integer
    field :winner, :string
    field :p1_choice, :string
    field :p2_choice, :string

    timestamps()
  end

  @doc false
  def changeset(round, attrs) do
    round
    |> cast(attrs, [:num, :winner, :p1_choice, :p2_choice])
    |> validate_required([:num])
  end
end
