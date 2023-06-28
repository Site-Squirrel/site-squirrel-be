require "rails_helper"

RSpec.describe Trip, type: :model do
  describe "relationships" do
    it { should belong_to :user}
    it { should have_many :reservation_days }
  end

  describe "validations" do
    it {should validate_presence_of :vehicle_length}
    it {should validate_presence_of :campground_id}
    it {should validate_presence_of :tent_site_ok}
    it {should validate_presence_of :name}
    it {should validate_presence_of :campground_location}
    it {should validate_presence_of :number_nights}
  end
end