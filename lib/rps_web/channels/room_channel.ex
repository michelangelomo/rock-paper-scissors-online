defmodule RpsWeb.RoomChannel do
  use Phoenix.Channel
  import Ecto.Query
  alias Rps.{Repo, Round}

  def join("room:" <> room_name, payload, socket) do
    %{"name" => name} = payload

    room = Repo.one(from r in Rps.Room, where: r.name == ^room_name)

    case room do
      nil ->
        Repo.insert(%Rps.Room{name: room_name, player1: name})
      _ ->
        room
        |> Ecto.Changeset.change(%{player2: name})
        |> Repo.update()
    end

    {:ok, socket
          |> assign(:player_name, name)
          |> assign(:room_id, room_name)
    }
  end

  def handle_in("start_round", _args, socket) do
    {:ok, round} = Repo.insert(%Round{}, on_conflict: :nothing)

    broadcast!(socket, "round_start", %{"round_id" => round.id})

    {:noreply, socket}
  end

  def handle_in("player_join", %{"room" => room_name, "player" => name}, socket) do
    room = Repo.one(from r in Rps.Room, where: r.name == ^room_name and (r.player1 == ^name or r.player2 == ^name), order_by: [desc: r.id], limit: 1)

    if name == room.player1 do
      broadcast!(socket, "player_join", %{ "p1" => name, "p2" => room.player2 })
    else
      broadcast!(socket, "player_join", %{ "p2" => name, "p1" => room.player1 })
    end

    {:noreply, socket}
  end

  def handle_in("make_choice", %{"choice" => choice, "round_id" => round_id}, socket) do
    room_name = socket.assigns.room_id
    player_name = socket.assigns.player_name

    room = Repo.one(from r in Rps.Room, where: r.name == ^room_name, order_by: [desc: r.id], limit: 1)
    round = Repo.one(from r in Round, where: r.id == ^round_id, order_by: [desc: r.id], limit: 1)

    p = whoami(room, player_name)

    case handle_round(p, choice, round) do
      {:waiting, player} ->
        broadcast! socket, "round_result", %{"message" => "Waiting for #{player}", "finish" => false}
      _ -> nil
    end

    round = Repo.one(from r in Round, where: r.id == ^round_id, order_by: [desc: r.id], limit: 1)

    case check_round(round) do
      {:result, winner} ->
        broadcast! socket, "round_result", %{"message" => "The winner is.... #{winner}!", "finish" => true}
      _ -> nil
    end

    {:noreply, socket}
  end

  defp whoami(room, player) do
    if player == Map.get(room, :player1) do
      :player1
    else
      :player2
    end
  end

  defp handle_round(p, choice, round) do
    if p == :player1 do
      round
      |> Ecto.Changeset.change(%{p1_choice: choice})
      |> Repo.update()
      {:waiting, :player2}
    else
      round
      |> Ecto.Changeset.change(%{p2_choice: choice})
      |> Repo.update()
      {:waiting, :player1}
    end
  end

  defp check_round(round) do
    if Map.get(round, :p1_choice) != nil and Map.get(round, :p2_choice) != nil do
      {:result, Rps.Rules.evaluate({Map.get(round, :p1_choice), Map.get(round, :p2_choice)})}
    else
      {:nothing}
    end
  end

end
