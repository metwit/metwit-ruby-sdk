require 'spec_helper'
module Metwit
  describe User do

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
        User.find("6576").should be_a User
      end

      it "should return a User with the id requested" do
        id = "6576"
        user = User.find(id)
        user.id.should eq id
      end
      
      it "should have all the guaranteed fields" do
        user = User.find("6576")
        user.id.should_not be_nil
        user.nickname.should_not be_nil
        user.metags_count.should_not be_nil
        user.today_metags_count.should_not be_nil
        user.avatar.should_not be_nil
        user.followed?.should_not
        user.followers_count.should_not be_nil
        user.following_count.should_not be_nil
        user.facebook?.should_not be_nil
        user.twitter?.should_not be_nil
      end
      
    end

    describe "::from_json" do
      around do |example|
        WebMock.disable_net_connect!
        url = BASE_URL + '/users/6576/'
        WebMock.stub_http_request(:get, url).to_return(fixture("user6576"))
        example.run
        WebMock.reset!
        WebMock.allow_net_connect!
      end

      def user
        url = BASE_URL + '/users/6576/'
        response = HTTParty.get(url)
        User.from_json(response)
      end

      it "should return a user with String id" do
        user.id.should be_a String
      end

      it "should return a user with String nickname" do
        user.nickname.should be_a String
      end

      it "should return a user with Fixnum metags_count" do
        user.metags_count.should be_a Fixnum
      end

      it "should return a user with Fixnum today_metags_count" do
        user.today_metags_count.should be_a Fixnum
      end

      it "should return a user with URI avatar" do
        user.avatar.should be_a URI
      end

      it "should return a user with Boolean followed" do
        user.followed?.should be_boolean
      end

      it "should return a user with Fixnum followers_count" do
        user.followers_count.should be_a Fixnum
      end


      it "should return a user with Fixnum following_count" do
        user.following_count.should be_a Fixnum
      end

      it "should return a user with Boolean facebook" do
        user.facebook?.should be_boolean
      end

      it "should return a user with Boolean twitter" do
        user.twitter?.should be_boolean
      end
            
    end
    
  end
end

