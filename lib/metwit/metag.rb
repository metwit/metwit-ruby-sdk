module Metwit
  # Metags are the weather tags
  class Metag
    # @!attribute [rw] weather
    #   @return [{Symbol => String, Hash}] weather data
    #   Is always required in a valid Metag.  
    #   Weather is an Hash with two keys: :status and :details  
    #   Valid :status values are:  
    #   :sunny, :rainy, :stormy, :snowy, :partly\_cloudy, :cloudy, :hailing, :heavy\_seas, :calm\_seas, :foggy, :snow\_flurries, :windy, :clear\_moon, :partly\_cloudy
    attr_accessor :weather

    def initialize
      @weather = Hash.new
    end

    # This method validates the metag for the submission
    # @return Boolean
    def valid?
      return false if @weather[:status].nil?
      return false unless weather_statuses.include?(@weather[:status])
      true
    end

    # This method return all the reognized weather statuses
    # @return Array<Symbol>
    def weather_statuses
      [:sunny, :rainy, :stormy, :snowy, :partly_cloudy, :cloudy, :hailing, :heavy_seas, :calm_seas, :foggy, :snow_flurries, :windy, :clear_moon, :partly_cloudy]
    end
        
  end
end
