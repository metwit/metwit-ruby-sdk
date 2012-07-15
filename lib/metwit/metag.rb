module Metwit
  class Metag
    # @!attribute [rw] weather
    #   @return Hash
    #   Is always required in a valid Metag.  
    #   Weather is an Hash with two keys: :status and :details
    #   Valid :status values are:  
    #   :sunny, :rainy, :stormy, :snowy, :partly\_cloudy, :cloudy, :hailing, :heavy\_seas, :calm\_seas, :foggy, :snow\_flurries, :windy, :clear\_moon, :partly\_cloudy
    attr_accessor :weather
  end
end
