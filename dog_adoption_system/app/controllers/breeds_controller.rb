class BreedsController < ApplicationController
  def index
    # Get all unique breeds with counts - simplified approach
    breeds_list = Dog.distinct.pluck(:breed).sort
    
    @breeds_data = breeds_list.map do |breed|
      dogs_in_breed = Dog.where(breed: breed)
      {
        breed: breed,
        total_count: dogs_in_breed.count,
        available_count: dogs_in_breed.where(available_for_adoption: true).count,
        adopted_count: dogs_in_breed.where(available_for_adoption: false).count
      }
    end
    
    @total_breeds = @breeds_data.count
  end

  def show
    @breed_name = params[:breed_name]
    @dogs = Dog.where(breed: @breed_name).order(:name)
    @available_dogs = @dogs.where(available_for_adoption: true)
    @adopted_dogs = @dogs.where(available_for_adoption: false)

    if @dogs.empty?
      redirect_to breeds_path, alert: "Breed '#{@breed_name}' not found."
      return
    end
    
    @breed_stats = {
      total: @dogs.count,
      available: @available_dogs.count,
      adopted: @adopted_dogs.count
    }
  end
end