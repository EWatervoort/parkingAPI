# Parking Lot API

## An API that can park or remove three different types of vehicles.

Key Features
- Park a car
- Remove a car
- List all spots
- List how many spots a certain type of vehicle is taking up
- Says when the parking lot is full
- Gives information on each spot from their ID

Assumptions
- The parking lot is a single row of spots
- The parking lot can hold motorcycles, cars, and vans
- The parking lot has motorcycle spots, car spots, and van spots
- A motorcycle can park in any spot
- A car can park in a single-car spot or a van spot
- A van can park a van spot or car spot, but it will take up 3 adjacent car spots

## Stack
- Ruby
- Ruby on Rails
- PostgreSQL

## Installation

1. Clone the repository
2. Start PostgreSQL
3. Create, Migrate, and Seed the database
```
rake db:create
rake db:migrate
rake db:seed
```
4. Start the server locally by running the command below.
```
rails s
```

## API Documentation

| Route                                | Description                                                                          | Method(s)  |
| ----------------------- | ------------------------------------------------------------------------------------------------- | ---------- |
| /spots                  | Returns a list of spots                                                                           | GET        |
| /spots/remaining        | Returns the number of remaining spots. Total, and per spot type. Returns full if the lot is full  | GET        |
| /spots/:car_type        | Returns the number of spots that the car_type is taking up                                        | Get        |
| /spots/id/:id           | Returns the information about the specific spot.                                                  | GET        |
| /spots/add/:car_type    | Updates the spot to have the car type added into the lot                                          | PATCH      |
| /spots/remove/:car_type | Updates the spot to have the car type removed from the lot                                        | PATCH      |

