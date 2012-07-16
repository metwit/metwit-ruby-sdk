module Metwit

  # A user of Metwit
  class User

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

    # Tells if you follow the user
    # @return [Boolean]
    def followed?
      @followed
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

    # Tells if the user is connected with facebook
    # @return [Boolean]
    def facebook?
      @has_facebook
    end
    
    # Tells if the user is connected with twitter
    def twitter?
      @has_twitter
    end

    # Private
    # The user email
    # @return [String]
    attr_accessor :email
    
  end
end
