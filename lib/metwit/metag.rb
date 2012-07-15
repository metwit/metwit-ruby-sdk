module Metwit
  # Metags are the weather tags
  class Metag
    # @!attribute [rw] weather
    #   @return [Hash] weather data
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
      
      
    end
        
  end
end
