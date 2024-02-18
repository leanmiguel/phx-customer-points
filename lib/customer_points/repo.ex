defmodule CustomerPoints.Repo do
  use Ecto.Repo,
    otp_app: :customer_points,
    adapter: Ecto.Adapters.SQLite3
end
