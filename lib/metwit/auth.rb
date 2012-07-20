module Metwit
  class << self
    attr_accessor :cookie

    def logged?
      @logged ||= false
    end
    
    def authenticate(username, password)
      @logged = false
      url = BASE_URL + '/users/login/'

      response = HTTParty.post(url, :body => {:username=>username, :password=>password})
      @cookie = response.headers['Set-Cookie']
      @logged = true if response.code == 200
      response
    end
  end
end
