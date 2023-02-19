defmodule MealsOnWheels.Repo.Migrations.MobileFoodSchedule do
  use Ecto.Migration

  def change do
    create table(:mobile_food_schedule) do
      add :truck_id, :string, null: false
      add :from, :string, null: false
      add :to, :string, null: false
      add :day, :integer, null: false
    end
  end
end
