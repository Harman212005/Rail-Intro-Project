class Dog < ApplicationRecord
  validates :breed, presence: true, length: { minimum: 2, maximum: 50 }
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :age, presence: true, numericality: { greater_than: 0, less_than: 25 }
  validates :image_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :available_for_adoption, inclusion: { in: [true, false] }

  has_many :adoptions, dependent: :destroy
  has_many :owners, through: :adoptions
  scope :available, -> { where(available_for_adoption: true) }
  scope :adopted, -> { where(available_for_adoption: false) }
end
