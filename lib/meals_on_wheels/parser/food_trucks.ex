defmodule MealsOnWheels.Parser.FoodTrucks do
  @base "https://data.sfgov.org/resource/rqzj-sfat.json"

  def fetch(_opts) do
    fetch_json() |> format_results()
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

  defp fetch_json() do
    case HTTPoison.get("#{@base}?") do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
