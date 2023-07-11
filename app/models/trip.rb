class Trip < ApplicationRecord
  belongs_to :user
  has_many :reservation_days

  validates :vehicle_length, :campground_id, :name, :campground_location, :number_nights, :user_id, presence: true
end
