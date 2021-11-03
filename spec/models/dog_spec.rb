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
end
