require 'spec_helper'
module Metwit
  describe Metag do
    def metag
      factory = RGeo::Cartesian.factory
      
      options = {
        :weather => {:status => :clear},
        :position => factory.point(1,2),
      }
      @metag ||= Metag.new(options)
    end

    describe "#weather_valid?" do
      it "should return false when weather is nil" do
        metag.weather = nil
        metag.weather_valid?.should_not be_true
      end

      it "should return false when weather[:status] is nil" do
        metag.weather[:status] = nil
        metag.weather_valid?.should_not be_true
      end

      it "should return false with an unrecogonized weather status" do
        metag.weather[:status] = :vola_tutto
        metag.weather_valid?.should_not be_true
      end

      it "should return true with a recognized weather status" do
        metag.weather_valid?.should be_true
      end

      it "should return false when weather[:status] is not a symbol" do
        metag.weather[:status] = 'sunny'
        metag.weather_valid?.should_not be_true
      end
      
      
    end

    describe "#position_valid?" do
      it "should return false when position is nil" do
        metag.position = nil
        metag.position_valid?.should_not be_true
      end

      it "should return false when position is not a geographical point" do
        gis = RGeo::Cartesian.factory
        metag.position = gis.line(gis.point(1,2), gis.point(2,1))
        metag.position_valid?.should_not be_true
      end

      it "should return true when position is a Point" do
        metag.position_valid?.should be_true
      end
      

    end

    describe "#valid?" do
      it "should return true with a valid metag" do
        metag.should be_valid
      end

      it "should return false with an invalid metag" do
        metag.position = nil
        metag.should_not be_valid
      end

    end
    

    describe "::find" do
      around do |example|
        WebMock.disable_net_connect!
        url = BASE_URL + '/metags/1234/'
        WebMock.stub_http_request(:get, url).to_return(fixture("metag1234"))
        example.run
        WebMock.reset!
        WebMock.allow_net_connect!
      end

      it "should return a Metag object" do
        Metag.find("1234").should be_a Metag
      end

      it "should return a Metag with the id requested" do
        id = "1234"
        metag = Metag.find(id)
        metag.id.should eq id
      end

      it "should have all the guaranteed fields" do
        metag = Metag.find("1234")
        metag.id.should_not be_nil
        metag.timestamp.should_not be_nil
        metag.weather.should_not be_nil
        metag.position.should_not be_nil
        metag.user.should_not be_nil
        metag.replies_count.should_not be_nil
        metag.thanks_count.should_not be_nil
      end

    end

    describe "#to_json" do
      it "should encode GeoJSON correctly" do
        json_metag = JSON.parse(metag.to_json)
        new_metag = Metag.new(:position => RGeo::GeoJSON.decode(json_metag['geo']))
        new_metag.position_valid?.should be_true
      end

      it "should encode weather status correctly" do
        json_metag = JSON.parse(metag.to_json)
        new_metag = Metag.new(:weather => {:status => json_metag['weather']['status'].gsub(/ /, '_').to_sym})
        new_metag.weather_valid?.should be_true
      end
      
    end

    describe "#create!" do
    end

    describe "::in_rect" do
    end
    
    describe "::from_json" do
      around do |example|
        WebMock.disable_net_connect!
        url = BASE_URL + '/metags/1234/'
        WebMock.stub_http_request(:get, url).to_return(fixture("metag1234"))
        example.run
        WebMock.reset!
        WebMock.allow_net_connect!
      end

      def metag
        url = BASE_URL + '/metags/1234/'
        response = HTTParty.get(url)
        Metag.from_json(response)
      end

      it "should return a metag with String id" do
        metag.id.should be_a String
      end

      it "should return a metag with Time timestamp" do
        metag.timestamp.should be_a Time
      end

      it "should return a metag with RGeo::Feature::Point position" do
        metag.position_valid?.should be_true
      end
      
      it "should return a metag with valid weather" do
        metag.weather_valid?.should be_true
      end

      it "should return a metag with User user" do
        metag.user.should be_a User
      end

      it "should return a metag with Fixnum replies_count" do
        metag.replies_count.should be_a Fixnum
      end

      it "should return a metag with Fixnum thanks_count" do
        metag.thanks_count.should be_a Fixnum
      end

    end
  end
end
