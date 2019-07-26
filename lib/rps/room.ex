defmodule Rps.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, []}
  schema "rooms" do
    field :name, :string
    field :player1, :string
    field :player2, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :player1, :player2])
    |> validate_required([:name])
  end
end
