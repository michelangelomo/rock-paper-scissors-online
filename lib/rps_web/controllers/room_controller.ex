defmodule RpsWeb.RoomController do
  use RpsWeb, :controller

  def new(conn, _params) do
    name = StringGenerator.string_of_length(8)
    redirect(conn, to: "/room/#{name}")
  end

  def show(conn, %{"name" => name}) do
    render(conn, "index.html", ["room_name": name])
  end
end

defmodule StringGenerator do
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")

  def string_of_length(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("") |> String.downcase()
  end
end

