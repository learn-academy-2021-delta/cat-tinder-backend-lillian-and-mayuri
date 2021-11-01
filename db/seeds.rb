# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dogs = [
    {
        name: "Snowball",
        age: 4,
        enjoys: "Lounging in the sun"
    },
    {
        name: "Ducky",
        age: 2,
        enjoys: "chasing yarn"
    },
    {
        name: "Garfield",
        age: 5,
        enjoys: "killing birds"
    },
    {
        name: "Taz",
        age: 10,
        enjoys: "eating tuna from a can"
    }
]

dogs.each do |attributes|
    Dog.create attributes
    p "creating dogs #{attributes}"
end