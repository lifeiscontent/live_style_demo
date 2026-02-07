defmodule LiveStyleDemo.Repo do
  use Ecto.Repo,
    otp_app: :live_style_demo,
    adapter: Ecto.Adapters.Postgres
end
