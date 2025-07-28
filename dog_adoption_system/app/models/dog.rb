class Dog < ApplicationRecord
  has_many :adoptions, dependent: :destroy
  
  has_many :owners, through: :adoptions
  
  scope :available, -> { where(available_for_adoption: true) }
  scope :adopted, -> { where(available_for_adoption: false) }
end
