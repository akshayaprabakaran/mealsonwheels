defmodule MealsOnWheels.MobileFoodFacilitiesTest do
  use MealsOnWheels.DataCase

  alias MealsOnWheels.MobileFoodFacilities

  describe "mobile_food_facilities" do
    alias MealsOnWheels.MobileFoodFacilities.MobileFoodFacility

    import MealsOnWheels.MobileFoodFacilitiesFixtures

    @invalid_attrs %{
      food_items: nil,
      latitude: nil,
      location: nil,
      longitude: nil,
      name: nil,
      schedule: nil
    }

    test "list_mobile_food_facilities/0 returns all mobile_food_facilities" do
      mobile_food_facility = mobile_food_facility_fixture()
      assert MobileFoodFacilities.list_mobile_food_facilities() == [mobile_food_facility]
    end

    test "get_mobile_food_facility!/1 returns the mobile_food_facility with given id" do
      mobile_food_facility = mobile_food_facility_fixture()

      assert MobileFoodFacilities.get_mobile_food_facility!(mobile_food_facility.id) ==
               mobile_food_facility
    end

    test "create_mobile_food_facility/1 with valid data creates a mobile_food_facility" do
      valid_attrs = %{
        food_items: "some food_items",
        latitude: 120.5,
        location: "some location",
        longitude: 120.5,
        name: "some name",
        schedule: "some schedule"
      }

      assert {:ok, %MobileFoodFacility{} = mobile_food_facility} =
               MobileFoodFacilities.create_mobile_food_facility(valid_attrs)

      assert mobile_food_facility.food_items == "some food_items"
      assert mobile_food_facility.latitude == 120.5
      assert mobile_food_facility.location == "some location"
      assert mobile_food_facility.longitude == 120.5
      assert mobile_food_facility.name == "some name"
      assert mobile_food_facility.schedule == "some schedule"
    end

    test "create_mobile_food_facility/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               MobileFoodFacilities.create_mobile_food_facility(@invalid_attrs)
    end

    test "update_mobile_food_facility/2 with valid data updates the mobile_food_facility" do
      mobile_food_facility = mobile_food_facility_fixture()

      update_attrs = %{
        food_items: "some updated food_items",
        latitude: 456.7,
        location: "some updated location",
        longitude: 456.7,
        name: "some updated name",
        schedule: "some updated schedule"
      }

      assert {:ok, %MobileFoodFacility{} = mobile_food_facility} =
               MobileFoodFacilities.update_mobile_food_facility(
                 mobile_food_facility,
                 update_attrs
               )

      assert mobile_food_facility.food_items == "some updated food_items"
      assert mobile_food_facility.latitude == 456.7
      assert mobile_food_facility.location == "some updated location"
      assert mobile_food_facility.longitude == 456.7
      assert mobile_food_facility.name == "some updated name"
      assert mobile_food_facility.schedule == "some updated schedule"
    end

    test "update_mobile_food_facility/2 with invalid data returns error changeset" do
      mobile_food_facility = mobile_food_facility_fixture()

      assert {:error, %Ecto.Changeset{}} =
               MobileFoodFacilities.update_mobile_food_facility(
                 mobile_food_facility,
                 @invalid_attrs
               )

      assert mobile_food_facility ==
               MobileFoodFacilities.get_mobile_food_facility!(mobile_food_facility.id)
    end

    test "delete_mobile_food_facility/1 deletes the mobile_food_facility" do
      mobile_food_facility = mobile_food_facility_fixture()

      assert {:ok, %MobileFoodFacility{}} =
               MobileFoodFacilities.delete_mobile_food_facility(mobile_food_facility)

      assert_raise Ecto.NoResultsError, fn ->
        MobileFoodFacilities.get_mobile_food_facility!(mobile_food_facility.id)
      end
    end

    test "change_mobile_food_facility/1 returns a mobile_food_facility changeset" do
      mobile_food_facility = mobile_food_facility_fixture()

      assert %Ecto.Changeset{} =
               MobileFoodFacilities.change_mobile_food_facility(mobile_food_facility)
    end
  end
end
