defmodule MealsOnWheels.Parser.FoodTruckSchedule do
  @base "https://data.sfgov.org/resource/bbb8-hzi6.json"

  def fetch(_opts) do
    "#{@base}?"
    |> HTTPoison.get()
    |> MealsOnWheels.Parser.ParserHelpers.fetch_json()
    |> format_results()
  end

  defp format_results({:ok, result}) do
    result
    |> Enum.map(&build_mfc_schedule_map(&1))
  end

  defp build_mfc_schedule_map(result) do
    %{
      truck_id: result["permit"],
      from: result["starttime"],
      to: result["endtime"],
      day: result["dayorder"]
    }
  end
end
