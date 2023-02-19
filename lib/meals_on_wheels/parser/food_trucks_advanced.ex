defmodule MealsOnWheels.Parser.FoodTrucksAdvanced do
  @base "priv/repo/food_trucks_data/food_trucks_advanced.json"

  def fetch(_opts) do
    fetch_json() |> format_results()
  end

  defp format_results({:ok, result}) do
    result
    |> Enum.map(&build_mfc_schedule_map(&1))
  end

  defp build_mfc_schedule_map(result) do
    %{
      mfc_id: result["mfc_id"],
      rating: result["rating"],
      preptime: result["preptime"],
      payment_method: result["payment_method"],
      cuisine: result["cuisine"]
    }
  end

  defp fetch_json() do
    with {:ok, body} <- File.read(@base), {:ok, json} <- Poison.decode(body), do: {:ok, json}
  end
end
