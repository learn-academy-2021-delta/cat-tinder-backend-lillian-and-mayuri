class DogsController < ApplicationController
  def index
    dogs = Dog.all
    render json: dogs
  end

  def create
    dog = Dog.create(dog_params)
    if dog.valid?
    render json: dog
    else
    render json: dog.errors, status: 422
    end
  end

  def update
        dog = Dog.find(params[:id])
        dog.update(dog_params)
        render json: dog
      end
    end

    def destroy
        dog = Dog.find(params[:id])
        dog.destroy
        render json: dog
        end

  private
    def dog_params
        params.require(:dog).permit(:name, :age, :enjoys)
    end
end
