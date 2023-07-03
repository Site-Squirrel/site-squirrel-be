require 'rails_helper'

RSpec.describe AvailabilityService do
  before(:each) do
    @service = AvailabilityService.new(232_450, '2023-10-01')
  end

  describe 'exists and has an api call', :vcr do
    it 'is a service' do
      expect(@service).to be_a(AvailabilityService)
    end

    it 'has a connection to faraday' do
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it 'returns a hash of campground availability data' do
      result = @service.get_availability

      expect(result).to be_a(Hash)
      expect(result).to have_key(:campsites)
      expect(result[:campsites]).to be_a(Hash)
      result[:campsites].keys.each do |key|
        expect(result[:campsites][key]).to have_key(:site)
        expect(result[:campsites][key]).to have_key(:availabilities)
        expect(result[:campsites][key]).to have_key(:campsite_id)
        expect(result[:campsites][key]).to have_key(:campsite_type)
        expect(result[:campsites][key]).to have_key(:capacity_rating)
        expect(result[:campsites][key]).to have_key(:loop)
        expect(result[:campsites][key]).to have_key(:max_num_people)
        expect(result[:campsites][key]).to have_key(:min_num_people)
        expect(result[:campsites][key][:availabilities]).to be_a(Hash)
        expect(result[:campsites][key][:availabilities].keys.count).to eq(15)
      end
    end
  end
end
