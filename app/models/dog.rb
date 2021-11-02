class Dog < ApplicationRecord
validates :name, :age, :enjoys, presence: true
validates :enjoys, length: {minimum: 10}
end
