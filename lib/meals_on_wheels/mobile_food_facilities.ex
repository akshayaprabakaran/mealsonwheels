defmodule MealsOnWheels.MobileFoodFacilities do
  @moduledoc """
  The MobileFoodFacilities context.
  """

  import Ecto.Query, warn: false

  alias MealsOnWheels.MobileFoodAdvanced.MobileFoodAdvanced
  alias MealsOnWheels.MobileFoodFacilities.MobileFoodFacility
  alias MealsOnWheels.MobileFoodSchedule.MobileFoodSchedule
  alias MealsOnWheels.Repo

  @office_point %{coordinates: {-122.3961006684713, 37.78798864899526}, srid: 4326}

  @doc """
  Returns the list of mobile_food_facilities.

  ## Examples

      iex> list_mobile_food_facilities()
      [%MobileFoodFacility{}, ...]

  """
  @spec list_mobile_food_facilities() :: [MobileFoodFacility.t()]
  def list_mobile_food_facilities do
    Repo.all(MobileFoodFacility)
  end

  @spec list_food_trucks(params :: map()) :: [map()]
  def list_food_trucks(params) do
    params
    |> build_food_truck_query()
    |> Repo.all()
  end

  @spec food_truck_timings(id :: Integer.t()) :: [map()]
  def food_truck_timings(id) do
    truck_ids = food_truck_ids(id) |> List.flatten()

    MobileFoodSchedule
    |> where([mfs], mfs.truck_id in ^truck_ids)
    |> select([mfs, mfc], %{
      days: fragment("array_agg(?)", mfs.day),
      from: fragment("array_agg(?)", mfs.from),
      to: fragment("array_agg(?)", mfs.to)
    })
    |> Repo.all()
  end

  @spec search_food_trucks(search_phrase :: String.t()) :: [map()]
  def search_food_trucks(search_phrase) do
    build_food_truck_query(%{})
    |> where(
      [mfc, mfs, mfa],
      fragment("SIMILARITY(?, ?) > 0.1", mfc.name, ^search_phrase) or
        fragment("SIMILARITY(?, ?) > 0.1", mfa.cuisine, ^search_phrase)
    )
    |> order_by([mfc, mfs, mfa], fragment("LEVENSHTEIN(?, ?)", mfc.name, ^search_phrase))
    |> Repo.all()
  end

  @doc """
  Gets a single mobile_food_facility.

  Raises `Ecto.NoResultsError` if the Mobile food facility does not exist.

  ## Examples

      iex> get_mobile_food_facility!(123)
      %MobileFoodFacility{}

      iex> get_mobile_food_facility!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_mobile_food_facility!(id :: Integer.t()) ::
          MobileFoodFacility.t() | Ecto.NoResultsError.t()
  def get_mobile_food_facility!(id), do: Repo.get!(MobileFoodFacility, id)

  @doc """
  Creates a mobile_food_facility.

  ## Examples

      iex> create_mobile_food_facility(%{field: value})
      {:ok, %MobileFoodFacility{}}

      iex> create_mobile_food_facility(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_mobile_food_facility(attrs :: map()) ::
          {:ok, MobileFoodFacility.t()} | {:error, Ecto.Changeset.t()}
  def create_mobile_food_facility(attrs \\ %{}) do
    %MobileFoodFacility{}
    |> MobileFoodFacility.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mobile_food_facility.

  ## Examples

      iex> update_mobile_food_facility(mobile_food_facility, %{field: new_value})
      {:ok, %MobileFoodFacility{}}

      iex> update_mobile_food_facility(mobile_food_facility, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_mobile_food_facility(
          mobile_food_facility :: MobileFoodFacility.t(),
          attrs :: map()
        ) :: {:ok, MobileFoodFacility.t()} | {:error, Ecto.Changeset.t()}
  def update_mobile_food_facility(%MobileFoodFacility{} = mobile_food_facility, attrs) do
    mobile_food_facility
    |> MobileFoodFacility.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mobile_food_facility.

  ## Examples

      iex> delete_mobile_food_facility(mobile_food_facility)
      {:ok, %MobileFoodFacility{}}

      iex> delete_mobile_food_facility(mobile_food_facility)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_mobile_food_facility(mobile_food_facility :: MobileFoodFacility.t()) ::
          {:ok, MobileFoodFacility.t()} | {:error, Ecto.Changeset.t()}
  def delete_mobile_food_facility(%MobileFoodFacility{} = mobile_food_facility) do
    Repo.delete(mobile_food_facility)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mobile_food_facility changes.

  ## Examples

      iex> change_mobile_food_facility(mobile_food_facility)
      %Ecto.Changeset{data: %MobileFoodFacility{}}

  """
  @spec change_mobile_food_facility(
          mobile_food_facility :: MobileFoodFacility.t(),
          attrs :: map()
        ) :: Ecto.Changeset.t()
  def change_mobile_food_facility(%MobileFoodFacility{} = mobile_food_facility, attrs \\ %{}) do
    MobileFoodFacility.changeset(mobile_food_facility, attrs)
  end

  defp build_food_truck_query(params) do
    MobileFoodFacility
    |> join(:inner, [mfc], mfs in MobileFoodSchedule, on: mfc.truck_id == mfs.truck_id)
    |> join(:inner, [mfc, mfs], mfa in MobileFoodAdvanced, on: mfc.id == mfa.mfc_id)
    |> where([mfc, mfs, mfa], mfc.type == :truck)
    |> distinct([mfc, mfs, mfa], mfc.name)
    |> select(
      [mfc, mfs, mfa],
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
    )
    |> filter_with(params)
  end

  defp food_truck_ids(name) do
    MobileFoodFacility
    |> where([mfc, mfs], mfc.name == ^name)
    |> group_by([mfc, mfs], mfc.id)
    |> select([mfc, mfs], fragment("array_agg(?)", mfc.truck_id))
    |> Repo.all()
  end

  defp filter_with(query, %{distance: radius_in_miles}) do
    radius_in_meters = radius_in_miles * 1609.344

    {lng, lat} = @office_point.coordinates

    query
    |> where(
      [mfc, mfs, mfa],
      fragment(
        "ST_DWithin(?::geography, ST_SetSRID(ST_MakePoint(?, ?), ?), ?)",
        mfc.coordinates,
        ^lng,
        ^lat,
        ^@office_point.srid,
        ^radius_in_meters
      )
    )
    |> order_by_nearest()
  end

  defp filter_with(query, %{prep_time: 15}) do
    query |> where([mfc, mfs, mfa], mfa.preptime <= 15)
  end

  defp filter_with(query, %{prep_time: 30}) do
    query |> where([mfc, mfs, mfa], mfa.preptime > 16)
  end

  defp filter_with(query, %{cuisine: cuisine}) do
    query |> where([mfc, mfs, mfa], mfa.cuisine == ^cuisine)
  end

  defp filter_with(query, %{payment_method: payment_method}) do
    query |> where([mfc, mfs, mfa], mfa.payment_method == ^payment_method)
  end

  defp filter_with(query, %{}) do
    query
  end

  defp order_by_nearest(query) do
    {lng, lat} = @office_point.coordinates

    query
    |> order_by(
      [mfc, mfs, mfa],
      fragment(
        "? <-> ST_SetSRID(ST_MakePoint(?,?), ?)",
        mfc.coordinates,
        ^lng,
        ^lat,
        ^@office_point.srid
      )
    )
  end
end
