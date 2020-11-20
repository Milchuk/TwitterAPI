# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :twitter,
  ecto_repos: [Twitter.Repo]

# Configures the endpoint
config :twitter, TwitterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lSJydCQfseajm+xMH7jACTF3Yz+JzCry68CHRoZr9M8PR1wQ7q40RcA+JUgmlrFz",
  render_errors: [view: TwitterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Twitter.PubSub,
  live_view: [signing_salt: "UEQSeHV1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

#Guardian config
config :twitter, Twitter.Guardian,
  issuer: "twitter",
  secret_key: "qsZ5vFmkSb2gVhV4VEYXRTi4YvoonD5Pt4zv+Ht/xvsYD4eWPouEvRSM2yBQT67K"