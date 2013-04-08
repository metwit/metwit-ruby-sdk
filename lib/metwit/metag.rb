require 'rgeo'
require 'rgeo-geojson'
require 'httparty'
require 'json'

module Metwit

  # Metags are the weather tags
  class Metag
    include HTTParty
    base_uri(BASE_URL+'/metags')

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
    # @return [RGeo::Feature::Point] geo location of the metag
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
      return false unless weather_valid?
      return false unless position_valid?
      true
    end

    # This method check if the weathear is valid
    # @return [Boolean]
    def weather_valid?
      return false if @weather.nil?
      return false if @weather[:status].nil?
      return false unless weather_statuses.include?(@weather[:status])
      true
    end

    # This method check if the position is valid
    # @return [Boolean]
    def position_valid?
      return false if @position.nil?
      return false unless RGeo::Feature::Point.check_type(@position)
      true
    end


    # This method return all the reognized weather statuses
    # @return [Array<Symbol>]
    def weather_statuses
      [:clear, :rainy, :stormy, :snowy, :partly_cloudy, :cloudy, :hailing, :heavy_seas, :calm_seas, :foggy, :snow_flurries, :windy, :partly_cloudy]
    end

    # This method encode metag in json for submission
    # @return [String]
    def to_json
      raise "metag in invalid" unless valid?

      {
        weather: {
          status: self.weather[:status].to_s.gsub(/_/,' '),
        },
        geo: RGeo::GeoJSON.encode(self.position),
      }.to_json
    end

    # This metod POST a metag
    def create!
      raise "invalid metag" unless self.valid?
      response = self.class.post('/', authenticated(:body => self.to_json, :headers => {'Content-Type' => 'application/json'}))
      raise "post failed" unless response.code == 201
      response
    end

    class << self
      # Return the metag associated with the id
      # @return [Metag]
      def find(id)
        response = get("/#{id}/", authenticated({}))
        raise "http error" unless response.code == 200
        self.from_json(response)
      end

      # Return metags in a geographical region
      # @return [Array<Metag>]
      def in_rect(lat_n, lng_w, lat_s, lng_e)
        response = get('/', authenticated(:query => {:rect => "#{lat_n},#{lng_w},#{lat_s},#{lng_e}"}))
        raise "in_rect error" unless response.code == 200
        metags = []
        response['objects'].each do |metag_json|
          metags << self.from_json(metag_json)
        end
        metags
      end

      # Return last metags posted
      # @return [Array<Metag>]
      def feed
        response = get('/', authenticated({}))
        raise "feed error" unless response.code == 200
        metags = []
        response['objects'].each do |metag_json|
          metags << self.from_json(metag_json)
        end
        metags
      end

      # Return a metag form a JSON response
      # @return [User]
      def from_json(response)
        args = {
          id: response['id'],
          timestamp: Time.parse(response['timestamp']),
          weather: {status: response['weather']['status'].gsub(/ /, '_').to_sym},
          position: RGeo::GeoJSON.decode(response['geo']),
          user: User.from_json(response['user']),
          replies_count: response['replies_count'],
          thanks_count: response['thanks_count'],
        }
        Metag.new(args)
      end

      # Default HTTParty options
      # @return [Hash]
      def authenticated(opts)
#        opts.deep_merge(:headers => {'Authorization' => "Bearer #{Metwit.bearer_token}"})
      end

    end

    # HTTParty options for authenticaded calls
    # @return [Hash]
    def authenticated(opts)
      self.class.authenticated(opts)
    end

  end
end
