defmodule MealsOnWheels.Factory do
  use ExMachina.Ecto, repo: MealsOnWheels.Repo

  alias MealsOnWheels.MobileFoodFacilities.MobileFoodFacility
  alias MealsOnWheels.MobileFoodSchedule.MobileFoodSchedule
  alias MealsOnWheels.MobileFoodAdvanced.MobileFoodAdvanced

  @spec mobile_food_facility_factory(attrs :: map()) :: MobileFoodFacility.t()
  def mobile_food_facility_factory(attrs \\ %{}) do
    long = Map.get(attrs, :longitude, Faker.Address.longitude())
    lat = Map.get(attrs, :latitude, Faker.Address.latitude())
    coordinates = %Geo.Point{coordinates: {long, lat}, srid: 4326}

    %MobileFoodFacility{
      name: Map.get(attrs, :name, Faker.Company.name()),
      food_items:
        Map.get(attrs, :food_items, Faker.Food.dish() <> Faker.Food.dish() <> Faker.Food.dish()),
      coordinates: Map.get(attrs, :coordinates, coordinates),
      location: Map.get(attrs, :location, Faker.Address.street_address()),
      schedule: Map.get(attrs, :location, Faker.Lorem.sentence(5, "")),
      type: Map.get(attrs, :type, Enum.random([:push_cart, :truck])),
      truck_id: Map.get(attrs, :truck_id, Enum.random(0..20) |> to_string()),
      longitude: Map.get(attrs, :name, long),
      latitude: Map.get(attrs, :name, lat)
    }
  end

  @spec mobile_food_schedule_factory(attrs :: map()) :: MobileFoodSchedule.t()
  def mobile_food_schedule_factory(attrs \\ %{}) do
    %MobileFoodSchedule{
      truck_id: Map.get(attrs, :truck_id, Enum.random(0..20) |> to_string()),
      from: Map.get(attrs, :from, "#{Enum.random(8..11)}" <> "AM"),
      to: Map.get(attrs, :to, "#{Enum.random(12..10)}" <> "PM"),
      day: Map.get(attrs, :day, Enum.random(0..6))
    }
  end

  @spec mobile_food_advanced_factory(attrs :: map()) :: MobileFoodAdvanced.t()
  def mobile_food_advanced_factory(attrs \\ %{}) do
    %MobileFoodAdvanced{
      mfc_id: Map.get(attrs, :mfc_id, build(:mobile_food_facility).id),
      rating: Map.get(attrs, :rating, Enum.random(2..5)),
      preptime: Map.get(attrs, :preptime, Enum.random(10..30)),
      payment_method:
        Map.get(
          attrs,
          :payment_method,
          Enum.random(["Cash Only", "Digital Only", "Cash/Digital"])
        ),
      cuisine: Map.get(attrs, :cuisine, Enum.random(["Mexican", "Italian", "Multi-Cuisine"]))
    }
  end
end
