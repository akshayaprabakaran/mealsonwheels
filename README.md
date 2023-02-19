# Meals On Wheels

Meals On Wheels is a web application that lists all food trucks in San Francisco.

## Project Goal

The goal of this project is to allow users to find food trucks in San Francisco. The data for the food trucks is fetched from DataSF's datasets. DataSF seeks to transform the way the City works through the use of data. The data from DataSF is used to populate our database. 

## What can Estée Lauder team do with Meals On Wheels?

Estée Lauder team will be able to 
  * ***search for food trucks by name***, and Meals On Wheels will return a list of food trucks that match their search criteria.
  * ***filter the food trucks by nearest Distance*** (<3miles, <5miles, <10miles) from their office location in San Francisco(random point), and Meals On Wheels will return a list of food trucks that match their distance criteria.
  * ***filter the food trucks by food preparation time*** (<15mins and 16 - 30mins), and Meals On Wheels will return a list of food trucks that match their prep time criteria.
  * ***filter the food trucks by cuisine*** (Mexican, Italian, Multi-Cuisine.....), and Meals On Wheels will return a list of food trucks that match their cuisine criteria.
  * ***filter the food trucks by food payment method***, and Meals On Wheels will return a list of food trucks that match their payment method criteria.
  * find the ***ratings and number of reviews*** of each food truck.
  * find the ***location*** of each food truck.
  * find the ***timings*** of each food truck.
  

Assuming you have elixir installed on your machine, please get started with the following steps to take a bite at your favorite food truck:

(In case, you don't have elixir installed, You can download Elixir from the official website for your operating system)

To start your Phoenix server:


  * Clone this project with `git clone https://github.com/akshayaprabakaran/Meals-On-wheels.git`
  * Install dependencies with `mix deps.get`
  * Create, migrate and populate your database with `SEED=true mix ecto.setup`. 
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/meals_on_wheels`](http://localhost:4000/meals_on_wheels) from your browser.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
