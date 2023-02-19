defmodule MealsOnWheels.MobileFoodFacilitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MealsOnWheels.MobileFoodFacilities` context.
  """

  @doc """
  Generate a mobile_food_facility.
  """
  def mobile_food_facility_fixture(attrs \\ %{}) do
    {:ok, mobile_food_facility} =
      attrs
      |> Enum.into(%{
        food_items: "some food_items",
        latitude: 120.5,
        location: "some location",
        longitude: 120.5,
        name: "some name",
        schedule: "some schedule"
      })
      |> MealsOnWheels.MobileFoodFacilities.create_mobile_food_facility()

    mobile_food_facility
  end
end
