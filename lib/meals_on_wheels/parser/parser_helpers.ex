defmodule MealsOnWheels.Parser.ParserHelpers do
  def fetch_json({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, Jason.decode!(body)}
  end

  def fetch_json({:ok, %HTTPoison.Response{status_code: 404}}) do
    {:error, :not_found}
  end

  def fetch_json({:ok, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
