defmodule MealsOnWheelsWeb.MealsOnWheelsLive.Index do
  use MealsOnWheelsWeb, :live_view

  import Ecto.Changeset
  alias MealsOnWheels.MobileFoodFacilities

  @types %{search_phrase: :string}

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:food_trucks, list_food_trucks())
      |> assign(:changeset, search_changeset())
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"_target" => ["search", "search_phrase"], "search" => %{"search_phrase" => ""}},
        socket
      ) do
    {:noreply, assign(socket, :food_trucks, list_food_trucks())}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"_target" => ["search", "search_phrase"], "search" => %{"search_phrase" => search}},
        socket
      ) do
    search = %{"search_phrase" => search}

    search
    |> search_changeset()
    |> case do
      %{valid?: true, changes: %{search_phrase: search_phrase}} ->
        {:noreply,
         assign(socket, :food_trucks, MobileFoodFacilities.search_food_trucks(search_phrase))}

      _ ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"_target" => ["filter", "filter_by_distance"], "filter" => filter},
        socket
      ) do
    filter_by = filter["filter_by_distance"] |> map_filters()

    {:noreply,
     assign(
       socket,
       :food_trucks,
       list_food_trucks(%{distance: filter_by})
     )}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"_target" => ["filter", "filter_by_prep_time"], "filter" => filter},
        socket
      ) do
    filter_by = filter["filter_by_prep_time"] |> map_filters()

    {:noreply,
     assign(
       socket,
       :food_trucks,
       list_food_trucks(%{prep_time: filter_by})
     )}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"_target" => ["filter", "filter_by_cuisine"], "filter" => filter},
        socket
      ) do
    {:noreply,
     assign(
       socket,
       :food_trucks,
       list_food_trucks(%{cuisine: filter["filter_by_cuisine"]})
     )}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"_target" => ["filter", "filter_by_payment"], "filter" => filter},
        socket
      ) do
    {:noreply,
     assign(
       socket,
       :food_trucks,
       list_food_trucks(%{payment_method: filter["filter_by_payment"]})
     )}
  end

  defp map_filters(filter) do
    String.to_integer(filter)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "San Francisco Food Trucks")
    |> assign(:food_truck, nil)
  end

  defp list_food_trucks(params \\ %{}) do
    MobileFoodFacilities.list_food_trucks(params)
  end

  defp food_truck_timings(food_truck_name) do
    timings = MobileFoodFacilities.food_truck_timings(food_truck_name)

    timings
    |> Enum.map(fn ft ->
      days = day_mappings(ft.days)
      time = time_mappings(ft.from, ft.to)

      Enum.zip_reduce([days, time], [], fn elements, acc ->
        [elements | acc]
      end)
      |> Enum.map(&Enum.join(&1, " "))
    end)
    |> List.flatten()
    |> Enum.reverse()
  end

  defp day_mappings(days_list) do
    day_names =
      ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
      |> Enum.zip(0..6)
      |> Enum.into(%{}, fn {name, key} -> {key, name <> " "} end)

    days_list
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.map(&day_names[&1])
  end

  defp time_mappings(from, to) do
    Enum.zip_reduce([from, to], [], fn elements, acc ->
      [elements | acc]
    end)
    |> Enum.map(&Enum.join(&1, "-"))
  end

  def rating_stars(rating) do
    stars =
      filled_stars(rating)
      |> Enum.concat(unfilled_stars(rating))
      |> Enum.join(" ")

    reviews_count = " (#{Enum.random(50..150)})"

    stars <> reviews_count
  end

  defp filled_stars(stars) do
    List.duplicate("&#x2605;", stars)
  end

  defp unfilled_stars(stars) do
    List.duplicate("&#x2606;", 5 - stars)
  end

  defp search_changeset(attrs \\ %{}) do
    cast(
      {%{}, @types},
      attrs,
      [:search_phrase]
    )
    |> validate_required([:search_phrase])
    |> update_change(:search_phrase, &String.trim/1)
    |> validate_length(:search_phrase, min: 2)
    |> validate_format(:search_phrase, ~r/[A-Za-z0-9\ ]/)
  end
end
