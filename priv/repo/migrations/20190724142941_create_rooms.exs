defmodule Rps.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :player1, :string
      add :player2, :string

      timestamps()
    end

  end
end
