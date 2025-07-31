class BreedsController < ApplicationController
  def index
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
    @search_performed = params[:search].present?
    @search_term = params[:search]&.strip
    
    all_dogs_in_breed = Dog.where(breed: @breed_name)
    
    if all_dogs_in_breed.empty?
      redirect_to breeds_path, alert: "Breed '#{@breed_name}' not found."
      return
    end
    
    @dogs = all_dogs_in_breed.order(:name)
    
    if @search_performed && @search_term.present?
      @dogs = @dogs.where(
        "name LIKE ? OR description LIKE ?", 
        "%#{@search_term}%", "%#{@search_term}%"
      )
    end
    
    @available_dogs = @dogs.where(available_for_adoption: true)
    @adopted_dogs = @dogs.where(available_for_adoption: false)
    
    @breed_stats = {
      total: @dogs.count,
      available: @available_dogs.count,
      adopted: @adopted_dogs.count
    }
  end
end