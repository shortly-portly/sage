# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sage,
  ecto_repos: [Sage.Repo]

# Configures the endpoint
config :sage, SageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1f9Gd5vfWLHiAAczTB803Zq9cJ+cWYlEUykd4f/9+3zKq5AoH0Pqf8RQiKOhZoos",
  render_errors: [view: SageWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Sage.PubSub,
  live_view: [signing_salt: "0RmNmODc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  colors: [error: :yellow]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
