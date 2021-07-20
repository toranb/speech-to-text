# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :voice, VoiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WY9qkNxRos30n7tq63poD+050uTngiSb58UxHWjNHwz2zTnNdZBYCD1UTA41s+Vx",
  render_errors: [view: VoiceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Voice.PubSub,
  live_view: [signing_salt: "dmsYt9r+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
