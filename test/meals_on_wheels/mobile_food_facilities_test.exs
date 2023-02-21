defmodule MealsOnWheels.MobileFoodFacilitiesTest do
  use MealsOnWheels.DataCase

  import Assertions
  import MealsOnWheels.Factory

  alias MealsOnWheels.MobileFoodFacilities

  describe "mobile_food_facilities" do
    test "list_food_trucks/1 returns all food_trucks details" do
      mfc_1 = insert(:mobile_food_facility, %{type: :truck, truck_id: "3"})
      mfc_2 = insert(:mobile_food_facility, %{type: :truck, truck_id: "5"})
      _mfc_3 = insert(:mobile_food_facility, %{type: :truck, name: mfc_1.name, truck_id: "5"})
      _schedule_1 = insert(:mobile_food_schedule, %{truck_id: "5"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "3"})
      mfa_1 = insert(:mobile_food_advanced, %{mfc_id: mfc_1.id})
      mfa_2 = insert(:mobile_food_advanced, %{mfc_id: mfc_2.id})

      food_trucks =
        Enum.map([{mfc_1, mfa_1}, {mfc_2, mfa_2}], fn {mfc, mfa} ->
          %{
            id: mfc.id,
            name: mfc.name,
            location: mfc.location,
            rating: mfa.rating,
            cuisine: mfa.cuisine,
            prep_time: mfa.preptime,
            type: mfc.type,
            payment_method: mfa.payment_method
          }
        end)

      _push_cart = insert(:mobile_food_facility, %{type: :push_cart, truck_id: "3"})
      assert_lists_equal(MobileFoodFacilities.list_food_trucks(%{}), food_trucks)
    end

    test "list_food_trucks/1 returns all food_trucks based on distance filter in miles" do
      mfc_within_1mile =
        insert(:mobile_food_facility, %{
          type: :truck,
          truck_id: "3",
          longitude: -122.38580966125056,
          latitude: 37.79510426218426
        })

      mfc_not_within_1mile =
        insert(:mobile_food_facility, %{
          type: :truck,
          truck_id: "5",
          longitude: -122.44188202520413,
          latitude: 37.74382081705027
        })

      _mfc_3 =
        insert(:mobile_food_facility, %{type: :truck, name: mfc_within_1mile.name, truck_id: "5"})

      _schedule_1 = insert(:mobile_food_schedule, %{truck_id: "5"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "3"})
      mfa_1 = insert(:mobile_food_advanced, %{mfc_id: mfc_within_1mile.id})
      _mfa_2 = insert(:mobile_food_advanced, %{mfc_id: mfc_not_within_1mile.id})

      food_truck = [
        %{
          id: mfc_within_1mile.id,
          name: mfc_within_1mile.name,
          location: mfc_within_1mile.location,
          rating: mfa_1.rating,
          cuisine: mfa_1.cuisine,
          prep_time: mfa_1.preptime,
          type: mfc_within_1mile.type,
          payment_method: mfa_1.payment_method
        }
      ]

      assert_lists_equal(MobileFoodFacilities.list_food_trucks(%{distance: 1}), food_truck)
    end

    test "list_food_trucks/1 returns all food_trucks based on cuisine filter" do
      mfc_1 = insert(:mobile_food_facility, %{type: :truck, truck_id: "3"})
      mfc_2 = insert(:mobile_food_facility, %{type: :truck, truck_id: "5"})
      _schedule_1 = insert(:mobile_food_schedule, %{truck_id: "5"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "3"})
      _mfa_mexican = insert(:mobile_food_advanced, %{cuisine: "Mexican", mfc_id: mfc_1.id})
      mfa_italian = insert(:mobile_food_advanced, %{cuisine: "Italian", mfc_id: mfc_2.id})

      food_truck = [
        %{
          id: mfc_2.id,
          name: mfc_2.name,
          location: mfc_2.location,
          rating: mfa_italian.rating,
          cuisine: mfa_italian.cuisine,
          prep_time: mfa_italian.preptime,
          type: mfc_1.type,
          payment_method: mfa_italian.payment_method
        }
      ]

      assert_lists_equal(MobileFoodFacilities.list_food_trucks(%{cuisine: "Italian"}), food_truck)
    end

    test "list_food_trucks/1 returns all food_trucks less than given preptime filter in mins" do
      mfc_1 = insert(:mobile_food_facility, %{type: :truck, truck_id: "3"})
      mfc_2 = insert(:mobile_food_facility, %{type: :truck, truck_id: "5"})
      _schedule_1 = insert(:mobile_food_schedule, %{truck_id: "5"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "3"})
      _mfa_25mins = insert(:mobile_food_advanced, %{preptime: 25, mfc_id: mfc_1.id})
      mfa_5mins = insert(:mobile_food_advanced, %{preptime: 5, mfc_id: mfc_2.id})

      food_truck = [
        %{
          id: mfc_2.id,
          name: mfc_2.name,
          location: mfc_2.location,
          rating: mfa_5mins.rating,
          cuisine: mfa_5mins.cuisine,
          prep_time: mfa_5mins.preptime,
          type: mfc_1.type,
          payment_method: mfa_5mins.payment_method
        }
      ]

      assert_lists_equal(MobileFoodFacilities.list_food_trucks(%{prep_time: 15}), food_truck)
    end

    test "list_food_trucks/1 returns all food_trucks for the given payment method" do
      mfc_1 = insert(:mobile_food_facility, %{type: :truck, truck_id: "3"})
      mfc_2 = insert(:mobile_food_facility, %{type: :truck, truck_id: "5"})
      _schedule_1 = insert(:mobile_food_schedule, %{truck_id: "5"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "3"})
      _mfa_digital = insert(:mobile_food_advanced, %{payment_method: "Digital Only", mfc_id: mfc_1.id})
      mfa_cash = insert(:mobile_food_advanced, %{payment_method: "Cash Only", mfc_id: mfc_2.id})

      food_truck = [
        %{
          id: mfc_2.id,
          name: mfc_2.name,
          location: mfc_2.location,
          rating: mfa_cash.rating,
          cuisine: mfa_cash.cuisine,
          prep_time: mfa_cash.preptime,
          type: mfc_1.type,
          payment_method: mfa_cash.payment_method
        }
      ]

      assert_lists_equal(MobileFoodFacilities.list_food_trucks(%{payment_method: "Cash Only"}), food_truck)
    end

    test "food_truck_timings/1 returns given food_truck name's timings" do
      _mfc_1 = insert(:mobile_food_facility, %{type: :truck, name: "FT", truck_id: "3"})
      _mfc_2 = insert(:mobile_food_facility, %{type: :truck, name: "FT", truck_id: "4"})
      _mfc_3 = insert(:mobile_food_facility, %{type: :truck, truck_id: "5"})
      schedule_1 = insert(:mobile_food_schedule, %{truck_id: "3"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "5"})
      schedule_3 = insert(:mobile_food_schedule, %{truck_id: "4"})

      food_truck_timing = [
        %{
          days: [schedule_1.day, schedule_3.day],
          from: [schedule_1.from, schedule_3.from],
          to: [schedule_1.to, schedule_3.to]
        }
      ]

      _push_cart = insert(:mobile_food_facility, %{type: :push_cart, truck_id: "3"})
      assert MobileFoodFacilities.food_truck_timings("FT") == food_truck_timing
    end

    test "search_food_trucks/1 returns food trucks that match given search phrase" do
      mfc_1 = insert(:mobile_food_facility, %{type: :truck, name: "Burger truck", truck_id: "3"})
      mfc_2 = insert(:mobile_food_facility, %{type: :truck, name: "burrito truck", truck_id: "5"})
      _mfc_3 = insert(:mobile_food_facility, %{type: :truck, name: "cream trcuk", truck_id: "5"})
      _schedule_1 = insert(:mobile_food_schedule, %{truck_id: "5"})
      _schedule_2 = insert(:mobile_food_schedule, %{truck_id: "3"})
      mfa_1 = insert(:mobile_food_advanced, %{mfc_id: mfc_1.id})
      mfa_2 = insert(:mobile_food_advanced, %{mfc_id: mfc_2.id})

      food_trucks =
        Enum.map([{mfc_1, mfa_1}, {mfc_2, mfa_2}], fn {mfc, mfa} ->
          %{
            id: mfc.id,
            name: mfc.name,
            location: mfc.location,
            rating: mfa.rating,
            cuisine: mfa.cuisine,
            prep_time: mfa.preptime,
            type: mfc.type,
            payment_method: mfa.payment_method
          }
        end)

      _push_cart =
        insert(:mobile_food_facility, %{
          type: :push_cart,
          name: "buffalo wings truck",
          truck_id: "3"
        })

      assert_lists_equal(MobileFoodFacilities.search_food_trucks("Bu"), food_trucks)
    end
  end
end
