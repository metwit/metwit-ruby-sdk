require 'rgeo'

module Metwit

  # Metags are the weather tags
  class Metag

    # Mandatory and guaranteed.  
    # Weather is an Hash with two keys: :status and :details  
    # Valid :status values are:  
    # :clear, :rainy, :stormy, :snowy, :partly\_cloudy, :cloudy, :hailing, :heavy\_seas, :calm\_seas, :foggy, :snow\_flurries, :windy, :partly\_cloudy, :uknown
    # @return [{Symbol => String, Hash}] weather data
    attr_accessor :weather

    # Guaranteed.
    # The metag id
    # @return [String] unique identifier of the metag
    attr_reader :id

    # Guaranteed.
    # The metag timestamp.
    # @return [Time] when the metag was created
    attr_reader :timestamp

    # Mandatory and guaranteed.
    # The geo location of the metag with GeoJSON format
    # @return [GeoJSON] geo location of the metag
    attr_accessor :position
      
    def initialize(options={})
      @weather = options[:weather]
      @position = options[:position]
    end
    # This method validates the metag for the submission
    # @return [Boolean]
    def valid?
      return false if @weather[:status].nil?
      return false unless weather_statuses.include?(@weather[:status])
      return false if @position.nil?
      return false unless RGeo::Feature::Point.check_type(@position)
      true
    end

    # This method return all the reognized weather statuses
    # @return [Array<Symbol>]
    def weather_statuses
      [:sunny, :rainy, :stormy, :snowy, :partly_cloudy, :cloudy, :hailing, :heavy_seas, :calm_seas, :foggy, :snow_flurries, :windy, :clear_moon, :partly_cloudy]
    end
        
  end
end
