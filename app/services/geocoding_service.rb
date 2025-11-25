class  GeocodingService
  Result = Struct.new(:success?, :zipcode, :lat, :lon, :city, :error)

  def initialize(address)
    @address = address
  end

  def call
    begin
      result = Geocoder.search(@address).first
      return Result.new(false, nil, nil, nil, "Address not found") unless result
      zipcode = result.postal_code
      lat = result.latitude
      lon = result.longitude
      city = result.city
      Result.new(true, zipcode, lat, lon, city, nil)
    rescue => e
      Result.new(false, nil, nil, nil, e.message)
    end
  end
end
