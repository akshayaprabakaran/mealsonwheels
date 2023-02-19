defmodule MealsOnWheels.Repo.Migrations.CreateMobileFoodFacilities do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS postgis")

    create table(:mobile_food_facilities) do
      add :name, :string, null: false
      add :location, :string, null: false
      add :food_items, :text, default: "Unlisted"
      add :schedule, :text, null: false
      add :truck_id, :string, null: false
    end

    execute("SELECT AddGeometryColumn ('mobile_food_facilities','coordinates',4326,'POINT',2);")
    create index(:mobile_food_facilities, [:coordinates], using: :gist)
  end

  def down do
    drop table(:mobile_food_facilities)
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
