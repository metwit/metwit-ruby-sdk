module Metwit
  class << self
    
    # The developer api key
    attr_accessor :api_key

    # The user access token
    attr_accessor :access_token

    # Tell if login was successuful
    # @return [Boolean]
    def logged?
      @logged ||= false
    end

    # Exchange the developer api key for a user access token
    def authenticate(username, password)
      @logged = false
      url = BASE_URL + '/auth/'

      response = HTTParty.post(url, :body => {:username=>username, :password=>password}, :headers => {'Authorization' => "Bearer #{@api_key}"})
      @access_token = response['bearer_token']
      @logged = true if response.code == 200
      response
    end

    def bearer_token
      self.logged? ? @access_token : @api_key
    end
        
  end
end
