# Meals On Wheels

Meals On Wheels is a web application that lists all food trucks in San Francisco. Here is how the interface looks:


## Project Goal

The goal of this project is to allow users to find food trucks in San Francisco. The data for the food trucks is fetched from DataSF's datasets. DataSF seeks to transform the way the City works through the use of data. The data from DataSF is used to populate Meals On Wheels's database. 

## What can Estée Lauder team do with Meals On Wheels?

Estée Lauder team will be able to 
  * ***search for food trucks by name***, and Meals On Wheels will return a list of food trucks that match their search criteria.
  

https://user-images.githubusercontent.com/43679591/219936506-9f329db1-26e0-4c56-9fc1-16ec3c9437b7.mov


  * ***filter the food trucks by nearest Distance*** (<3miles, <5miles, <10miles) from their office location in San Francisco(random point), and Meals On Wheels will return a list of food trucks that match their distance criteria.


https://user-images.githubusercontent.com/43679591/219936518-f6562063-8ca7-417d-b380-d16cf413e5b3.mov



  * ***filter the food trucks by food preparation time*** (<15mins and 16 - 30mins), and Meals On Wheels will return a list of food trucks that match their prep time criteria.


  * ***filter the food trucks by cuisine*** (Mexican, Italian, Multi-Cuisine.....), and Meals On Wheels will return a list of food trucks that match their cuisine criteria.
  * ***filter the food trucks by food payment method***, and Meals On Wheels will return a list of food trucks that match their payment method criteria.
  * find the ***ratings and number of reviews*** of each food truck.
  * find the ***location*** of each food truck.
  * find the ***timings*** of each food truck.
  
## Design and Implementation

To implement this project, I used the 
* ***Elixir*** programming language to create a web API that retrieves data from the city's open dataset using the ***HTTPoison*** library. 
* ***Supervisor*** library which ensures that the system remains robust and responsive, even in the face of errors or failures.
* ***Phoenix LiveView*** for leveraging the power of Phoenix channels to provide fast, low-latency updates to Meals On Wheels UI.
* ***Tailwind CSS*** for designing responsive and attractive user interface.
* ***Geo.PostGIS*** - geolocation functionality to enable Estée Lauder team to search from their's office location for nearest food trucks based on latitude and longitude coordinates. 

As a food lover myself, I felt these features can make Meals On Wheels more useful
* ***Ratings***
* ***Number of reviews***
* ***Food preparation time***
* ***Cuisine***
* ***Payment Method***

So created a dummy dataset for these columns and synced them with food truck data which was decoded using the json library ***Poison***.

## Tradeoffs and Future Work
During the implementation of this project, I had to make several tradeoffs to balance functionality with time. I focused on some important features like 

* asynchronously fetching data from each of Meals On Wheels's external API clients and storing them in db
* geolocation functionality
* searching and filtering
* clean/decent visualiization

If I had more time to work on this project, there are several things I would consider implementing
* pagination for better response time.
* efficient parsing of food items and mapping with relevant cuisine.
* geolocation functionality to enable users to find food trucks based on their current location.
* more appealing visualiization using grid layout/React components
* extensive documentation and testing to ensure that the application is well-documented and reliable.

## Instructions to use Meals On Wheels

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
