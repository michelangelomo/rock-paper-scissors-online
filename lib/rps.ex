defmodule Rps do
  @moduledoc """
  Rps keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defmodule Rules do
    def evaluate({player1, player2}) when player1 == player2, do: :draw

    def evaluate({player1 = "rock", player2 = "scissors"}), do: :player1

    def evaluate({player1 = "paper", player2 = "rock"}), do: :player1

    def evaluate({player1 = "scissors", player2 = "paper"}), do: :player1

    def evaluate({player1, player2}), do: :player2
  end
end
