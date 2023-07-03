class AvailabilityService
  def initialize(campground_id, start_date)
    @campground_id = campground_id
    # Start date format 2023-10-01
    @start_date = start_date
  end

  def get_availability
    get_url("/api/camps/availability/campground/#{@campground_id}/month?start_date=#{@start_date}T00%3A00%3A00.000Z")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://www.recreation.gov")
  end
end