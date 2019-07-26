defmodule Rps.Repo do
  use Ecto.Repo,
    otp_app: :rps,
    adapter: Ecto.Adapters.Postgres
end
