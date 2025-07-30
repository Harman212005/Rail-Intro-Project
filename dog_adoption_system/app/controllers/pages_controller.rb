class PagesController < ApplicationController
  def home
    @available_dogs_count = Dog.available.count
    @adopted_dogs_count = Dog.adopted.count
    @total_owners = Owner.count
    @total_adoptions = Adoption.count
    @recent_adoptions = Adoption.includes(:dog, :owner).recent.limit(5)
  end

  def about
  end
end