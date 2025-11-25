# Weather Forecast Application

This is a simple Ruby on Rails application that takes a city or address as input, converts it into latitude/longitude using the Geocoder gem, and then fetches the current weather details using the OpenWeather API. The weather results are cached for 30 minutes to reduce external API usage.

---

## Ruby version

- Ruby 3.x  
- Rails 8.x  

---

## System dependencies

This application uses the following gems:

- `geocoder` – for converting address to latitude/longitude  
- `httparty` – for calling the OpenWeather API  
- `dotenv-rails` – for loading API keys from `.env`  
- `rails` built-in caching system

---

## Configuration

1. Install required gems:
```bash
bundle install
```

2. Create a `.env` file in the root directory and add:
```
OPENWEATHER_KEY=your_api_key_here
```

3. Make sure the OpenWeather API key is valid and activated.

---

## Database creation

This project does not use a database, but Rails still requires one to exist.  
Create it using:

```bash
rails db:create
```

---

## Database initialization

There are no migrations or seeds required.  
You may run:

```bash
rails db:migrate
```

---

## How to run the test suite

If using RSpec:
```bash
bundle exec rspec
```

Tests can cover:

- Geocoding service  
- Weather service  
- Presenter  
- Controller flow  

---

## Services

### **GeocodingService**
- Converts the user-provided address into:
  - Latitude  
  - Longitude  
  - Zipcode  
  - City Name  

### **WeatherService**
- Calls the OpenWeather API  
- Retrieves:
  - Temperature  
  - Feels like  
  - Humidity  
  - Weather condition  
  - Weather icon  

### **ForecastPresenter**
- Structures and formats the API response for the view.

### **Rails Cache**
- Stores weather results for 30 minutes using a key pattern:
  - `forecast_<zipcode>` or  
  - `forecast_<lat>_<lon>`

---

## Deployment instructions

1. Install gems:
```bash
bundle install --deployment
```

2. Set environment variables:
```
export OPENWEATHER_KEY=your_api_key
```

3. Precompile assets:
```bash
rails assets:precompile
```

4. Start the server:
```bash
rails server
```

---

## Summary

This application:
- Accepts a city/address  
- Converts it to coordinates  
- Fetches weather from OpenWeather  
- Displays weather details in the UI  
- Caches results to improve speed  

This project follows good Rails practices using service objects, presenters, and caching.

