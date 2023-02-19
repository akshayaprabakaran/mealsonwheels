defmodule MealsOnWheels.MobileFoodAdvanced.MobileFoodAdvanced do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:mfc_id, :rating, :preptime, :payment_method, :cuisine]

  schema "mobile_food_advanced" do
    field :mfc_id, :integer
    field :rating, :integer
    field :preptime, :integer
    field :payment_method, :string
    field :cuisine, :string
  end

  @doc false
  def changeset(mobile_food_advanced, attrs) do
    mobile_food_advanced
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
