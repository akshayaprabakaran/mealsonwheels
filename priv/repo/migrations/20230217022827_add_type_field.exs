defmodule MealsOnWheels.Repo.Migrations.AddTypeField do
  use Ecto.Migration

  def change do
    alter table(:mobile_food_facilities) do
      add :type, :facility_type, null: true
    end
  end
end
