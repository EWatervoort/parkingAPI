# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
spots = Spot.create([
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "motorcycle"
    },
    {
        spot_type: "motorcycle"
    },
    {
        spot_type: "motorcycle"
    },
    {
        spot_type: "motorcycle"
    },
    {
        spot_type: "motorcycle",
        taken: "motorcycle"
    },
    {
        spot_type: "van",
    },
    {
        spot_type: "van",
    },
    {
        spot_type: "van",
    },
    {
        spot_type: "van",
    },
    {
        spot_type: "van",
        taken: "van"
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    },
    {
        spot_type: "car" 
    }

])