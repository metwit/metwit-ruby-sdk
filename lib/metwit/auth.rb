require 'base64'

module Metwit
  class << self

    # The developer application id
    attr_accessor :client_id

    # The developer application secret
    attr_accessor :client_secret

    # The access token
    attr_accessor :access_token

    # The refresh token
    attr_accessor :refresh_token

    # Tell if login was successuful
    # @return [Boolean]
    def logged?
      @logged ||= false
    end

    def refresh_access_token
      url = 'https://api.metwit.com/token/'
      response = HTTParty.post(url, :body => {:grant_type => 'refresh_token',
                               :refresh_token => refresh_token},
                               :headers => {'Authorization' => "Basic #{Base64.strict_encode64(client_id+":"+client_secret)}"})
      # TODO: check if correctly logged
      @logged = true
      @refresh_token = response['refresh_token'] if response['refresh_token']
      @access_token = response['access_token']
    end

    def get_access_token
      url = 'https://api.metwit.com/token/'
      response = HTTParty.post(url, :body => {:grant_type => 'client_credentials'},
                               :headers => {'Authorization' => "Basic #{Base64.strict_encode64(client_id+":"+client_secret)}"})
      # TODO: check if correctly logged
      @logged = true
      @refresh_token = response['refresh_token']
      @access_token = response['access_token']
    end
  end

  class AccessTokenExpiredError < StandardError ;  end
end
