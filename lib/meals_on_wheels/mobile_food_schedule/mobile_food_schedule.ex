defmodule MealsOnWheels.MobileFoodSchedule.MobileFoodSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:truck_id, :from, :to, :day]

  schema "mobile_food_schedule" do
    field :truck_id, :string
    field :from, :string
    field :to, :string
    field :day, :integer
  end

  @doc false
  def changeset(mobile_food_schedule, attrs) do
    mobile_food_schedule
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
