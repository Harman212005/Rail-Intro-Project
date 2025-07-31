class DogsController < ApplicationController
  def index
    @all_breeds = Dog.distinct.pluck(:breed).sort
    
    @dogs = Dog.all.order(:name)
    
    if params[:breed].present?
      @dogs = @dogs.where(breed: params[:breed])
      @breed_filter = params[:breed]
    end
    
    if params[:search].present?
      search_term = params[:search].strip
      @dogs = @dogs.where(
        "name LIKE ? OR breed LIKE ? OR description LIKE ?", 
        "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"
      )
      @search_performed = true
      @search_term = search_term
    end
    
    @available_dogs = @dogs.where(available_for_adoption: true).order(:name)
    @adopted_dogs = @dogs.where(available_for_adoption: false).order(:name)
    @total_count = @dogs.count
    @available_count = @available_dogs.count
    @adopted_count = @adopted_dogs.count
  end

  def show
    @dog = Dog.find(params[:id])
    @adoption = @dog.adoptions.includes(:owner).first
  end
end