require 'httparty'

module Metwit

  # A user of Metwit
  class User
    include HTTParty
    base_uri(BASE_URL+'/users')

    # Guaranteed.
    # The user id
    # @return [String] unique identifier of the user
    attr_reader :id

    # Guaranteed.
    # The user nickname
    # @return [String] nickname
    attr_accessor :nickname

    # Guaranteed.
    # Total number of metags sent by the user
    # @return [Fixnum] total number of metags
    attr_reader :metags_count

    # Guaranteed.
    # Number of metags sent today by the user
    # @return [Fixnum] today metags number
    attr_reader :today_metags_count

    # Guaranteed.
    # Avatar url
    # @return [URI] avatar url
    attr_accessor :avatar

    # Guaranteed.
    # Tells if you follow the user
    # @return [Boolean]
    def followed?
      @is_followed
    end

    # Guaranteed.
    # Followers count
    # @return [Fixnum] The number of followers
    attr_reader :followers_count

    # Guaranteed.
    # Following count
    # @return [Fixnum] The number of following users
    attr_reader :following_count

    # Sport activities
    # @return [Array<Symbol>] Sport activities array
    attr_accessor :activities

    # The badges the user earned
    # @return [Array<Symbol>] Bagdges
    attr_accessor :badges

    # Guaranteed.
    # Tells if the user is connected with facebook
    # @return [Boolean]
    def facebook?
      @has_facebook
    end

    # Guaranteed.
    # Tells if the user is connected with twitter
    def twitter?
      @has_twitter
    end

    # Personal
    # The user email
    # @return [String]
    attr_accessor :email

    def initialize(args={})
      @id = args[:id]
      @nickname = args[:nickname]
      @metags_count = args[:metags_count]
      @today_metags_count = args[:today_metags_count]
      @avatar = args[:avatar]
      @is_followed = args[:followed]
      @followers_count = args[:followers_count]
      @following_count = args[:following_count]
      @has_facebook = args[:has_facebook]
      @has_twitter = args[:has_twitter]
    end
    
    class << self
      # Return the user associate with the id
      # @return [User]
      def find(id)
        response = get("/#{id}/")
        raise "http error" unless response.code == 200
        user_from_json(response)
      end

      # Create a user from an HTTParty::Response
      # @return [User]
      def user_from_json(response)
        options = {
          id: response['id'],
          nickname: response['nickname'],
          metags_count: response['reports_count'],
          today_metags_count: response['todays_reports_count'],
          avatar: URI.parse(response['avatar_url']),
          followed: response['is_followed'],
          followers_count: response['followers_count'],
          following_count: response['following_count'],
          has_facebook: response['has_facebook'],
          has_twitter: response['has_twitter'],
        }
        User.new(options)
      end
            
    end
      
  end
end
