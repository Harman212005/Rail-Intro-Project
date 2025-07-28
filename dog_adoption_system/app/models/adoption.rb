class Owner < ApplicationRecord
  has_many :adoptions, dependent: :destroy
  has_many :dogs, through: :adoptions
end
