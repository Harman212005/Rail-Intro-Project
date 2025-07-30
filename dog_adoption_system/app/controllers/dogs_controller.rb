class DogsController < ApplicationController
  def index
    @dogs = Dog.all.order(:name)
    @available_dogs = Dog.available.order(:name)
    @adopted_dogs = Dog.adopted.order(:name)
    @total_count = @dogs.count
    @available_count = @available_dogs.count
    @adopted_count = @adopted_dogs.count
  end

  def show
    @dog = Dog.find(params[:id])
    @adoption = @dog.adoptions.includes(:owner).first
  end
end