# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :turkish_web, TurkishWeb.Endpoint,
  url: [host: "localhost"],
  static_url: [path: "/turkish"],
  secret_key_base: "QIkvOp5EDBUgqXv/TQXeDCmpoFLbWUb7+/sr3UQPmKIiU+k7EKKmN5bkFqJhnAzm",
  render_errors: [view: TurkishWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TurkishWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
