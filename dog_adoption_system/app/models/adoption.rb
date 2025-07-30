class Adoption < ApplicationRecord

  validates :adoption_date, presence: true
  validates :adoption_fee, presence: true, 
            numericality: { greater_than_or_equal_to: 0, less_than: 10000 }
  validates :notes, length: { maximum: 500 }
  validate :adoption_date_cannot_be_in_future

  belongs_to :dog
  belongs_to :owner

  scope :recent, -> { order(adoption_date: :desc) }
  scope :by_date, ->(date) { where(adoption_date: date) }

  private

  def adoption_date_cannot_be_in_future
    if adoption_date.present? && adoption_date > Date.current
      errors.add(:adoption_date, "can't be in the future")
    end
  end
end