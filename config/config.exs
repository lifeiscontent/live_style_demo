# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :live_style_demo,
  generators: [timestamp_type: :utc_datetime]

# Configure the endpoint
config :live_style_demo, LiveStyleDemoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: LiveStyleDemoWeb.ErrorHTML, json: LiveStyleDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LiveStyleDemo.PubSub,
  live_view: [signing_salt: "dbbXuIK1"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  live_style_demo: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure LiveStyle
config :live_style,
  prefix_css: &AutoprefixerEx.prefix_css/2,
  deprecated?: &CSSCompatDataEx.deprecated?/1,
  default: [
    output: "priv/static/assets/live.css",
    cd: Path.expand("..", __DIR__)
  ]

# Configure AutoprefixerEx
config :autoprefixer_ex,
  browserslist: ["defaults"]

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
