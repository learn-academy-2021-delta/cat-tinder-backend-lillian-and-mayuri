require 'rails_helper'

RSpec.describe Dog, type: :model do
  it "should validate name" do
    dog = Dog.create(age: 1, enjoys: 'all the attention')
    expect(dog.errors[:name]).to_not be_empty
  end

  it 'should have a valid age' do
      dog = Dog.create(name: 'Toast', enjoys: 'all the attention')
      expect(dog.errors[:age].first).to eq "can't be blank"
    end

    it 'should have a valid enjoys' do
      dog = Dog.create(name: 'Toast', age: 3)
      expect(dog.errors[:enjoys].first).to eq "can't be blank"
    end

    it 'should have an enjoys entry of at least 10 characters' do
    dog = Dog.create(name: 'Toast', age: 3, enjoys: 'food')
    expect(dog.errors[:enjoys].first).to eq 'is too short (minimum is 10 characters)'
  end

  it 'does not create a dog with an age' do
      dog_params = {
        dog: {
          name: 'Toast',
          enjoys: 'Eats garden veggies'
        }
      }
      post '/dogs', params: dog_params
      expect(response).to have_http_status(422)
      dog = JSON.parse(response.body)
      expect(dog['age']).to include "can't be blank"
    end

    it 'does not create a dog with an enjoys' do
      dog_params = {
        dog: {
          name: 'Toast',
          age: 3
        }
      }
      post '/dogs', params: dog_params
      expect(response).to have_http_status(422)
      dog = JSON.parse(response.body)
      expect(dog['enjoys']).to include "can't be blank"
    end

    describe "cannot update a dog without valid attributes" do
    it 'cannot update a dog without a name' do
      dog_params = {
        dog: {
          name: 'Boo',
          age: 2,
          enjoys: 'cuddles and belly rubs'
        }
      }
      post '/dogs', params: dog_params
      dog = Dog.first
      dog_params = {
        dog: {
          name: '',
          age: 2,
          enjoys: 'cuddles and belly rubs'
        }
      }
      patch "/dogs/#{dog.id}", params: dog_params
      dog = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(dog['name']).to include "can't be blank"
    end
    it 'cannot update a dog without a age' do
      dog_params = {
        dog: {
          name: 'Boo',
          age: 2,
          enjoys: 'cuddles and belly rubs'
        }
      }
      post '/dogs', params: dog_params
      dog = Dog.first
      dog_params = {
        dog: {
          name: 'Boo',
          age: '',
          enjoys: 'cuddles and belly rubs'
        }
      }
      patch "/dogs/#{dog.id}", params: dog_params
      dog = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(dog['age']).to include "can't be blank"
    end
    it 'cannot update a dog without an enjoys' do
      dog_params = {
        dog: {
          name: 'Boo',
          age: 2,
          enjoys: 'cuddles and belly rubs'
        }
      }
      post '/dogs', params: dog_params
      dog = Dog.first
      dog_params = {
        dog: {
          name: 'Boo',
          age: 2,
          enjoys: '',
        }
      }
      patch "/dogs/#{dog.id}", params: dog_params
      dog = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(dog['enjoys']).to include "can't be blank"
    end
    it 'cannot update a dog without an enjoys that is at least 10 characters' do
      dog_params = {
        dog: {
          name: 'Boo',
          age: 2,
          enjoys: 'cuddles and belly rubs'
        }
      }
      post '/dogs', params: dog_params
      dog = Dog.first
      dog_params = {
        dog: {
          name: 'Boo',
          age: 2,
          enjoys: 'cuddles'
        }
      }
      patch "/dogs/#{dog.id}", params: dog_params
      dog = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(dog['enjoys']).to include 'is too short (minimum is 10 characters)'
    end
  end
end
