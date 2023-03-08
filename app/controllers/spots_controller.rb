class SpotsController < ApplicationController
  
  #shows all of the spots in the spots table 
  def index
    spots = Spot.all
    render json: spots, status: 200
  end

  # shows the information for a specific spot from the id
  def show
    spot = Spot.find_by(id: params[:id])
    if spot
      render json: spot, status: 200
    else
      render json: {error: "Spot not found"}
    end
  end

  # Checks whether the vehicle typed is one of the three allowed options
  def vehicle_test
    vehicle = params[:car_type]
    options = ["van", "motorcycle", "car"]
    if !options.include?(vehicle)
      abort "vehicle is not a car, van, or motorcycle"
    end
    vehicle
  end

  # Determines the number of spots left, total as well as per car type.
  # If there are no spots remaining it will indicate that the parking lot is full
  def remaining
    spots = Spot.where(taken: nil).count
    motorcycle = Spot.where(spot_type: "motorcycle", taken: nil).count
    car = Spot.where(spot_type: "car", taken: nil).count
    van = Spot.where(spot_type: "van", taken: nil).count
    if spots == 0
      render json: "The parking lot is full", status: 200
    elsif spots
      render json: 
      "There are #{spots} total spot(s) remaining
      Motorcycle: #{motorcycle}
      Car: #{car}
      Van: #{van}",
      status: 200
    else
      render json: "There are no spots remaining", status: 200
    end
  end

  # Determines how many spots each type of car is taking up
  def cars_per_type
    vehicle = vehicle_test
    spots = Spot.where(taken: vehicle).count
    render json: "#{vehicle}s are taking up #{spots} spot(s)", status: 200
  end

  # Sends a patch request to add a vehicle.
  def add_vehicle
    if Spot.where(taken: nil).count == 0
      render json: {error: "The parking lot is full"}
    else
      vehicle = vehicle_test
      if vehicle == "motorcycle"
        render json: add_motorcycle
      elsif vehicle == "car"
        render json: add_car
      elsif vehicle == "van"
        render json: add_van
      else
        render json: {error: "Not a valid vehicle type. Please use car, van, or motorcycle"}
      end
    end
  end

  # Finds the first empty spot for a specific spot type
  def empty_spot(vehicle)
    spot = Spot.find_by(spot_type: vehicle, taken: nil)
  end

  # Finds the first full spot for a specific spot type
  def full_spot(vehicle)
    spot = Spot.find_by(taken: vehicle)
    if spot.nil?
      return "error"
    end
    spot
  end

  # Checks for empty motorcycle spots, then car, then van, and adds a motorcycle to the first available
  def add_motorcycle
    spot = empty_spot("motorcycle")
    if !spot
      spot = empty_spot("car")
      if !spot
        spot = empty_spot("van")
      end
    end
    spot.taken = "motorcycle"
    spot.save!
    spot
  end

  # Checks for empty car spots then van spots and adds a car to the first available
  def add_car
    spot = empty_spot("car")
    if !spot
      spot = empty_spot("van")
      if !spot
        "There are no spots available for a car"
        return
      end
    end
    spot.taken = "car"
    spot.save!
    spot
  end

  # Checks for empty van spots and if none are available checks for at least 3 adjacent empty car spots
  def add_van
    spot = empty_spot("van")
    if spot
      spot.taken = "van"
      spot.save!
      spot
    else
      spots = Spot.where(spot_type: "car", taken: nil)
      if spots.count >= 3
        adjacent = consecutive(spots)
        if adjacent
          three = adjacent.first(3)
          three.each do |id| 
            spot = Spot.find_by(id: id)
            puts spot.id
            spot.taken = "van"
            spot.save!
          end
        else
          "Not enough room to add a van. At least 1 van spot or 3 adjacent car spots are needed"
        end
      else
        "Not enough room to add a van. At least 1 van spot or 3 adjacent car spots are needed"
      end
    end
  end

  # Finds the first 3 adjacent car spots
  def consecutive(spots)
    ids = spots.ids.sort
    output = ids.chunk_while {|i, j| i+1 == j }
    larger = output.select { |id| id.length >= 3}
    return larger[0]
  end

# Sends a patch request to remove the first vehicle found of that type and set the spot taken element to nil
  def remove_vehicle
    vehicle = vehicle_test
    spot = full_spot(vehicle)
    if spot.is_a? String
      render json: "There are no more #{vehicle}s in the parking lot to remove"
    elsif vehicle == "van" && spot.spot_type == "car"
      spots = Spot.where(spot_type: "car", taken: "van").first(3)
      spots.each do |s|
        s.taken = nil
        s.save!
      end
      render json: "Van removed", status: 200
    else
      spot.taken = nil
      render json: "#{vehicle} removed", status: 200
      spot.save! 
    end
  end


end
