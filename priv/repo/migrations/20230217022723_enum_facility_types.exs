defmodule MealsOnWheels.Repo.Migrations.EnumFacilityTypes do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create_type(:facility_type, [:push_cart, :truck], default: :push_cart)
  end
end
