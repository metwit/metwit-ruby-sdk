require 'spec_helper'
module Metwit
  describe User do
    def user
      options = {
        id: 3,
        nickname: 'verginge',
        metags_count: 100,
        today_metags_count: 2,
        avatar: URI('https://s3.salcazzo.amazon.com/di233hane'),
        is_followed: false,
        followers_count: 10,
        following_count: 100,
        has_facebook: true,
        has_twitter: false,
      }
      @user ||= User.new(options)
    end

    describe "::find" do

      around do |example|
        WebMock.disable_net_connect!
        url = BASE_URL + '/users/6576/'
        WebMock.stub_http_request(:get, url).to_return(fixture("user6576"))
        example.run
        WebMock.reset!
        WebMock.allow_net_connect!
      end
      
      it "should return a User object" do
        User.find(6576).should be_a User
      end

      it "should return a User with the id searched" do
        id = "6576"
        user = User.find(id)
        user.id.should eq id
      end
      
      it "should have all the guaranteed fields" do
        user = User.find(6576)
        user.id.should_not be_nil
        user.nickname.should_not be_nil
        user.metags_count.should_not be_nil
        user.today_metags_count.should_not be_nil
        user.avatar.should_not be_nil
        user.followed?.should_not
        user.followers_count.should_not be_nil
        user.following_count.should_not be_nil
        user.facebook?
        user.twitter?
      end
      
    end
    
  end
end

