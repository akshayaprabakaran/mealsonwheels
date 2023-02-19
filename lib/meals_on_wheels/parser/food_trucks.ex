defmodule MealsOnWheels.Parser.FoodTrucks do
  @base "https://data.sfgov.org/resource/rqzj-sfat.json"

  def fetch(_opts) do
    "#{@base}?"
    |> HTTPoison.get()
    |> MealsOnWheels.Parser.ParserHelpers.fetch_json()
    |> format_results()
  end

  defp format_results({:ok, result}) do
    result
    |> Enum.map(&build_mfc_map(&1))
  end

  defp build_mfc_map(result) do
    %{
      name: result["applicant"],
      type:
        case result["facilitytype"] do
          "Push Cart" -> :push_cart
          "Truck" -> :truck
          _ -> nil
        end,
      location: result["address"],
      latitude: result["latitude"] |> float_logic(),
      longitude: result["longitude"] |> float_logic(),
      food_items: result["fooditems"],
      schedule: result["schedule"],
      truck_id: result["permit"]
    }
  end

  defp float_logic(value) do
    case value |> Float.parse() do
      {float, _} -> float
    end
  end
end
