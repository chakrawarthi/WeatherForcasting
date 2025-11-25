class WeatherService
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5"

  Result = Struct.new(:success?, :payload, :error)

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def fetch_weather
    begin
      response = self.class.get("/weather", {
        query: {
          lat: @lat,
          lon: @lon,
          appid: ENV["OPENWEATHER_KEY"],
          units: "metric"
        }
      })
      response
      return Result.new(false, nil, "Weather service error") unless response.code == 200

      data = response.parsed_response
      payload = {
        temp: data["main"]["temp"],
        feels_like: data["main"]["feels_like"],
        humidity: data["main"]["humidity"],
        condition: data["weather"][0]["description"],
        max_temp: data["main"]["temp_max"]
      }

      Result.new(true, payload, nil)
    rescue => e
      Result.new(false, nil, e.message)
    end
  end
end
