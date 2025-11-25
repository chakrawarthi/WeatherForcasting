class ForecastPresenter
  def initialize(weather, geo)
    @weather = weather
    @geo = geo
  end

  def to_hash
    {
      location: {
        zipcode: @geo.zipcode,
        lat: @geo.lat,
        lon: @geo.lon,
        city: @geo.city
      },
      current_weather: @weather
    }
  end
end
