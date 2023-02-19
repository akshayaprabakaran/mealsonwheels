defmodule MealsOnWheels.Repo do
  use Ecto.Repo,
    otp_app: :meals_on_wheels,
    adapter: Ecto.Adapters.Postgres
end
