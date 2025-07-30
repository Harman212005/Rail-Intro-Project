class Owner < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, uniqueness: true, 
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, length: { minimum: 10, maximum: 20 }
  validates :address, presence: true, length: { minimum: 5, maximum: 200 }
  validates :city, presence: true, length: { minimum: 2, maximum: 50 }
  validates :state, presence: true, length: { minimum: 2, maximum: 50 }
  validates :zip_code, presence: true, 
            format: { with: /\A\d{5}(-\d{4})?\z/, message: "Invalid zip code format" }

  has_many :adoptions, dependent: :destroy
  
  has_many :dogs, through: :adoptions
end