module Metwit
  class Metag
    # @!attribute [rw] weather
    #   @return Hash
    #   Is always required in a valid Metag.  
    #   Weather is an Hash with two keys: :status and :details
    #   Valid :status values are:  
    #   :sunny, :rainy, :stormy, :snowy, :partly_cloudy, :cloudy, :hailing, :heavy_seas, :calm_seas, :foggy, :snow_flurries, :windy, :clear_moon, :partly_cloudy
    attr_accessor :weather
  end
end
