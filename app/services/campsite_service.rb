class CampsiteService
  def initialize(campsite_id)
    @campsite_id = campsite_id
  end

  def get_campsite_attributes
    get_url("api/v1/campsites/#{@campsite_id}?apikey=#{ENV['NP_KEY']}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://ridb.recreation.gov/')
  end
end
