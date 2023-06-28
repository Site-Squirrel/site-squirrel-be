class Trip < ApplicationRecord
  belongs_to :user
  has_many :reservation_days


  validates :vehicle_length, :campground_id, :tent_site_ok, :name, :campground_location, :number_nights, presence: true
end
