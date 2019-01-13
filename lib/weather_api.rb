class WeatherApi
  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch("weather-#{city}", expires_in: 1.week) { get_weather_in(city) }
  end

  def self.get_weather_in(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    response
  end

  def self.key
    raise "APIXU_APIKEY env variable not defined" if ENV['APIXU_APIKEY'].nil?

    ENV['APIXU_APIKEY']
  end
end

# 1889a145c4d8497488e164448191301
