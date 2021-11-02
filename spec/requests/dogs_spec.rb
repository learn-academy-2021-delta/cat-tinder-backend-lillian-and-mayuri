require 'rails_helper'

RSpec.describe "Dogs", type: :request do
  describe "GET /index" do
   it "gets a list of dogs" do
    Dog.create name:'Mosey', age: 5, enjoys: 'showing up in odd places randomly'
    get '/dogs'
    dog = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(dog.length).to eq 1
   end
  end

  describe "POST /create" do
      it "creates a dog" do

        dog_params = {
          dog: {
            name: 'Tiger',
            age: 5,
            enjoys: 'showing up in odd places randomly'
          }
        }

        post '/dogs', params: dog_params
        expect(response).to have_http_status(200)

        dog = Dog.first
        p dog.id
        expect(dog.name).to eq 'Tiger'
        expect(dog.age).to eq 5
        expect(dog.enjoys).to eq 'showing up in odd places randomly'
      end
    end

    describe "PATCH /update" do
    it "updates a dog" do
      dog_params = {
        dog: {
          name: 'Sparky',
          age: 9,
          enjoys: 'driving cars off a cliff'
        }
      }
      post '/dogs', params: dog_params
      dog = Dog.first

      updated_dog_params = {
        dog: {
          name: "Sparky",
          age: 10,
          enjoys: 'driving cars off a cliff'
        }
      }
      patch "/dogs/#{dog.id}", params: updated_dog_params
      dog = Dog.first
      expect(response).to have_http_status(200)
      expect(dog.age).to eq 10
    end
  end

  describe "DELETE /destroy" do
    it 'deletes a dog' do
      # create the dog
      dog_params = {
        dog: {
          name: 'Roger',
          age: 2,
          enjoys: 'Eats garden veggies'
        }
      }
      post '/dogs', params: dog_params
      dog = Dog.first
      delete "/dogs/#{dog.id}"
      expect(response).to have_http_status(200)
      dogs = Dog.all
      expect(dogs).to be_empty
    end
  end
  describe 'dog validation error codes' do
    it 'does not create a dog with a name' do
      dog_params = {
        dog: {
          age: 2,
          enjoys: 'Eats garden veggies'
        }
      }
      post '/dogs', params: dog_params
      expect(response).to have_http_status(422)
      dog = JSON.parse(response.body)
      expect(dog['name']).to include "can't be blank"
    end
  end
end
