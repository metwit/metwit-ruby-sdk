require 'rgeo'
require 'rgeo-geojson'
require 'httparty'
require 'json'

module Metwit
  class Weather
    include HTTParty
    base_uri(BASE_URL+'/weather')

    # Guaranteed.
    # Weather is an Hash with two keys: :status and :details
    # Valid :status values are:
    # :clear, :rainy, :stormy, :snowy, :partly\_cloudy, :cloudy, :hailing, :heavy\_seas, :calm\_seas, :foggy, :snow\_flurries, :windy, :partly\_cloudy, :uknown
    # @return [{Symbol => String, Hash}] weather data
    attr_reader :weather

    # Guaranteed.
    # The metag timestamp.
    # @return [Time] when the metag was created
    attr_reader :timestamp

    # Guaranteed.
    # The geo location of the metag with GeoJSON format
    # @return [RGeo::Feature::Point] geo location of the metag
    attr_reader :geo

    # The locality and country name for this geographical location
    attr_reader :location

    # The icon URL
    attr_reader :icon

    # The altitude of the sun
    attr_reader :sun_altitude

    # The sources for the weather status
    attr_reader :sources

    def initialize(args={})
      args.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    class << self

      # An array with current weather and weather forecast
      def in_location(lat, lng)
        response = get("/?location_lat=#{lat}&location_lng=#{lng}")
        raise "api error" unless response.code == 200
        response['objects'].map {|weather_json| self.from_json(weather_json)}
      end

      def from_json(response)
        self.new(timestamp: Time.parse(response['timestamp']),
                 weather: response['weather'],
                 geo: RGeo::GeoJSON.decode(response['geo']),
                 sun_altitude: response['sun_altitude'],
                 sources: response['sources'],
                 location: response['location'])
      end
    end
  end
end
