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

    # Guaranteed.
    # The issuer of the metag.
    # @return [User] the issuer of the metag
    attr_accessor :user

    # Guaranteed.
    # The number of replies
    # @return [Fixnum] the number of replies
    attr_accessor :replies_count

    # Guaranteed
    # The number of thanks
    # @return [Fixnum] the number of thanks
    attr_accessor :thanks_count
    
      
    def initialize(args={})
      @id = args[:id]
      @weather = args[:weather]
      @position = args[:position]
      @timestamp = args[:timestamp]
      @weather = args[:weather]
      @user = args[:user]
      @replies_count = args[:replies_count]
      @thanks_count = args[:thanks_count]
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

    class << self
      def find(id)
        return Metag.new(:id => "1234", :timestamp => Time.now, :weather => "chupa", :position => "12323", :user => User.new, :replies_count => 12, :thanks_count => 10)
      end
    end
    
  end
end
