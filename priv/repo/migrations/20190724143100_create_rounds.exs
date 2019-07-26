defmodule Rps.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :num, :integer
      add :winner, :string
      add :p1_choice, :string
      add :p2_choice, :string

      timestamps()
    end

  end
end
