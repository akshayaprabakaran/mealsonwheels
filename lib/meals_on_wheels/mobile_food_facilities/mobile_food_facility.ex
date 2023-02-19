defmodule MealsOnWheels.MobileFoodFacilities.MobileFoodFacility do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields [
    :name,
    :location,
    :schedule,
    :type,
    :truck_id,
    :coordinates,
    :latitude,
    :longitude
  ]
  @optional_fields [:food_items]

  schema "mobile_food_facilities" do
    field :food_items, :string
    field :coordinates, Geo.PostGIS.Geometry
    field :distance, :float, virtual: true
    field :location, :string
    field :name, :string
    field :schedule, :string
    field :type, Ecto.Enum, values: [:push_cart, :truck]
    field :truck_id, :string
    field :longitude, :float, virtual: true
    field :latitude, :float, virtual: true
  end

  @doc false
  def changeset(mobile_food_facility, attrs) do
    mobile_food_facility
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> cast_coordinates()
    |> validate_required(@required_fields)
  end

  def cast_coordinates(changeset) do
    latitude = get_change(changeset, :latitude)
    longitude = get_change(changeset, :longitude)
    geo = %Geo.Point{coordinates: {longitude, latitude}, srid: 4326}
    changeset |> put_change(:coordinates, geo)
  end
end
