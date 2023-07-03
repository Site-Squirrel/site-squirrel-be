require 'rails_helper'

RSpec.describe CampsiteService do
  before(:each) do
    @service = CampsiteService.new('906')
  end

  describe 'exists and has an api call', :vcr do
    it 'is a service' do
      expect(@service).to be_a(CampsiteService)
    end

    it 'has a connection to faraday' do
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it 'returns a hash of campground availability data' do
      result = @service.get_campsite_attributes

      expect(result.first).to have_key(:CampsiteID)
      expect(result.first).to have_key(:CampsiteLatitude)
      expect(result.first).to have_key(:CampsiteLongitude)
      expect(result.first).to have_key(:CampsiteName)
      expect(result.first).to have_key(:CampsiteAccessible)
      expect(result.first).to have_key(:CampsiteType)
      expect(result.first).to have_key(:CampsiteType)
      expect(result.first).to have_key(:CampsiteType)
      expect(result.first[:ATTRIBUTES]).to be_a(Array)
    end
  end
end
