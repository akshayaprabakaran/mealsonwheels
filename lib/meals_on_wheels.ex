defmodule MealsOnWheels do
  alias MealsOnWheels.Parser

  @clients [Parser.FoodTrucks, Parser.FoodTruckSchedule, Parser.FoodTrucksAdvanced]

  def fetch(opts \\ []) do
    timeout = opts[:timeout] || 2_000
    clients = opts[:clients] || @clients

    clients
    |> Enum.map(&async_query(&1, opts))
    |> Task.yield_many(timeout)
    |> Enum.map(fn {task, res} -> res || Task.shutdown(task, :brutal_kill) end)
    |> Enum.flat_map(fn
      {:ok, results} -> results
      _ -> []
    end)
    |> channel_store_data()
  end

  defp channel_store_data(data_list) do
    Enum.each(
      data_list,
      &cond do
        is_map_key(&1, :food_items) == true -> store_data(&1, :mobile_food_facilities)
        is_map_key(&1, :day) == true -> store_data(&1, :mobile_food_schedule)
        is_map_key(&1, :rating) == true -> store_data(&1, :mobile_food_advanced)
      end
    )
  end

  defp store_data(mobile_food_facility, :mobile_food_facilities) do
    MealsOnWheels.MobileFoodFacilities.create_mobile_food_facility(mobile_food_facility)
  end

  defp store_data(mobile_food_schedule, :mobile_food_schedule) do
    MealsOnWheels.MobileFoodSchedule.create_mobile_food_schedule(mobile_food_schedule)
  end

  defp store_data(mobile_food_advanced, :mobile_food_advanced) do
    MealsOnWheels.MobileFoodAdvanced.create_mobile_food_advanced(mobile_food_advanced)
  end

  defp async_query(client, opts) do
    Task.Supervisor.async_nolink(Parser.TaskSupervisor, client, :fetch, [opts],
      shutdown: :brutal_kill
    )
  end
end
