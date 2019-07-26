# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rps,
  ecto_repos: [Rps.Repo]

# Configures the endpoint
config :rps, RpsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/flfuhQRN7km6aJEuksN4tdjgCMoY6EBrZ/Ms9lZ1fauZySRna4xAPMZZQbv0J6K",
  render_errors: [view: RpsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rps.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
