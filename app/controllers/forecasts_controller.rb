class ForecastsController < ApplicationController

  def new

  end

  def create
    address = params[:address]
    redirect_to forecast_path(address: address)
  end

  def show
    address = params[:address]
    if address.blank?
      return render plain: "Please provide an address."
    end
    geo = GeocodingService.new(address).call
    return render plain: geo.error unless geo.success?

    key = "forecast_#{geo.zipcode || "#{geo.lat}_#{geo.lon}"}"
    cached = Rails.cache.read(key)
 	if cached
  		@forecast = cached.merge(from_cache: true)
  		return render :show
	end
    weather = WeatherService.new(geo.lat, geo.lon).fetch_weather
    return render plain: weather.error unless weather.success?
    presenter = ForecastPresenter.new(weather.payload, geo)
    output = presenter.to_hash.merge(from_cache: false)
    Rails.cache.write(key, output, expires_in: 30.minutes)
    @forecast = output
    render :show
  end

end
