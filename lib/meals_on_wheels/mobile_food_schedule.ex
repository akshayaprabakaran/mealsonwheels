defmodule MealsOnWheels.MobileFoodSchedule do
  @moduledoc """
  The MobileFoodSchedule context.
  """

  import Ecto.Query, warn: false
  alias MealsOnWheels.Repo

  alias MealsOnWheels.MobileFoodSchedule.MobileFoodSchedule

  @doc """
  Returns the list of mobile_food_schedule.

  ## Examples

      iex> list_mobile_food_schedule()
      [%MobileFoodSchedule{}, ...]

  """
  def list_mobile_food_schedule do
    Repo.all(MobileFoodSchedule)
  end

  @doc """
  Gets a single mobile_food_schedule.

  Raises `Ecto.NoResultsError` if the Mobile food facility does not exist.

  ## Examples

      iex> get_mobile_food_schedule!(123)
      %MobileFoodSchedule{}

      iex> get_mobile_food_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mobile_food_schedule!(id), do: Repo.get!(MobileFoodSchedule, id)

  @doc """
  Creates a mobile_food_schedule.

  ## Examples

      iex> create_mobile_food_schedule(%{field: value})
      {:ok, %MobileFoodSchedule{}}

      iex> create_mobile_food_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mobile_food_schedule(attrs \\ %{}) do
    %MobileFoodSchedule{}
    |> MobileFoodSchedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mobile_food_schedule.

  ## Examples

      iex> update_mobile_food_schedule(mobile_food_schedule, %{field: new_value})
      {:ok, %MobileFoodSchedule{}}

      iex> update_mobile_food_schedule(mobile_food_schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mobile_food_schedule(%MobileFoodSchedule{} = mobile_food_schedule, attrs) do
    mobile_food_schedule
    |> MobileFoodSchedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mobile_food_schedule.

  ## Examples

      iex> delete_mobile_food_schedule(mobile_food_schedule)
      {:ok, %MobileFoodSchedule{}}

      iex> delete_mobile_food_schedule(mobile_food_schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mobile_food_schedule(%MobileFoodSchedule{} = mobile_food_schedule) do
    Repo.delete(mobile_food_schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mobile_food_schedule changes.

  ## Examples

      iex> change_mobile_food_schedule(mobile_food_schedule)
      %Ecto.Changeset{data: %MobileFoodSchedule{}}

  """
  def change_mobile_food_schedule(%MobileFoodSchedule{} = mobile_food_schedule, attrs \\ %{}) do
    MobileFoodSchedule.changeset(mobile_food_schedule, attrs)
  end
end
