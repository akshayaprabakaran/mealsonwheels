defmodule MealsOnWheels.Repo.Migrations.MobileFoodAdvanced do
  use Ecto.Migration

  def change do
    create table(:mobile_food_advanced) do
      add :mfc_id, :integer, null: false
      add :rating, :integer, null: false
      add :preptime, :integer, null: false
      add :cuisine, :string, null: false
      add :payment_method, :string, null: false
    end
  end
end
