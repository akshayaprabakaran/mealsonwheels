defmodule MealsOnWheels.MobileFoodAdvanced do
  @moduledoc """
  The MobileFoodAdvanced context.
  """

  import Ecto.Query, warn: false
  alias MealsOnWheels.Repo

  alias MealsOnWheels.MobileFoodAdvanced.MobileFoodAdvanced

  @doc """
  Returns the list of mobile_food_advanced.

  ## Examples

      iex> list_mobile_food_advanced()
      [%MobileFoodAdvanced{}, ...]

  """
  @spec list_mobile_food_advanced :: [MobileFoodAdvanced.t()]
  def list_mobile_food_advanced do
    Repo.all(MobileFoodAdvanced)
  end

  @doc """
  Gets a single mobile_food_advanced.

  Raises `Ecto.NoResultsError` if the Mobile food facility does not exist.

  ## Examples

      iex> get_mobile_food_advanced!(123)
      %MobileFoodAdvanced{}

      iex> get_mobile_food_advanced!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_mobile_food_advanced!(id :: Integer.t()) ::
          MobileFoodAdvanced.t() | Ecto.NoResultsError.t()
  def get_mobile_food_advanced!(id), do: Repo.get!(MobileFoodAdvanced, id)

  @doc """
  Creates a mobile_food_advanced.

  ## Examples

      iex> create_mobile_food_advanced(%{field: value})
      {:ok, %MobileFoodAdvanced{}}

      iex> create_mobile_food_advanced(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_mobile_food_advanced(attrs :: map()) ::
          {:ok, MobileFoodAdvanced.t()} | {:error, Ecto.Changeset.t()}
  def create_mobile_food_advanced(attrs \\ %{}) do
    %MobileFoodAdvanced{}
    |> MobileFoodAdvanced.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mobile_food_advanced.

  ## Examples

      iex> update_mobile_food_advanced(mobile_food_advanced, %{field: new_value})
      {:ok, %MobileFoodAdvanced{}}

      iex> update_mobile_food_advanced(mobile_food_advanced, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_mobile_food_advanced(
          mobile_food_advanced :: MobileFoodAdvanced.t(),
          attrs :: map()
        ) ::
          {:ok, MobileFoodAdvanced.t()} | {:error, Ecto.Changeset.t()}
  def update_mobile_food_advanced(%MobileFoodAdvanced{} = mobile_food_advanced, attrs) do
    mobile_food_advanced
    |> MobileFoodAdvanced.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mobile_food_advanced.

  ## Examples

      iex> delete_mobile_food_advanced(mobile_food_advanced)
      {:ok, %MobileFoodAdvanced{}}

      iex> delete_mobile_food_advanced(mobile_food_advanced)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_mobile_food_advanced(mobile_food_advanced :: MobileFoodAdvanced.t()) ::
          {:ok, MobileFoodAdvanced.t()} | {:error, Ecto.Changeset.t()}
  def delete_mobile_food_advanced(%MobileFoodAdvanced{} = mobile_food_advanced) do
    Repo.delete(mobile_food_advanced)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mobile_food_advanced changes.

  ## Examples

      iex> change_mobile_food_advanced(mobile_food_advanced)
      %Ecto.Changeset{data: %MobileFoodAdvanced{}}

  """
  @spec change_mobile_food_advanced(
          mobile_food_advanced :: MobileFoodAdvanced.t(),
          attrs :: map()
        ) :: Ecto.Changeset.t()
  def change_mobile_food_advanced(%MobileFoodAdvanced{} = mobile_food_advanced, attrs \\ %{}) do
    MobileFoodAdvanced.changeset(mobile_food_advanced, attrs)
  end
end
