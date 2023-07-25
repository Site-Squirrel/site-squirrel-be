require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :reservation_days }
  end

  describe 'validations' do
    it { should validate_presence_of :vehicle_length }
    it { should validate_presence_of :campground_id }
    it { should validate_inclusion_of(:tent_site_ok).in_array([true, false]) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :campground_location }
    it { should validate_presence_of :number_nights }
  end

  describe 'methods' do
    it "can list active days" do
      user_1 = create(:user)
      trip_1 = create(:trip, user_id: user_1.id)
      res_day_1 = ReservationDay.create!(trip_id: trip_1.id, search_active: true, date: "2024-01-01")
      res_day_2 = ReservationDay.create!(trip_id: trip_1.id, search_active: false, date: "2024-01-01")

      expect(trip_1.active_days).to eq([res_day_1])
      expect(trip_1.active_days).to_not eq([res_day_2])
    end
  end
end
