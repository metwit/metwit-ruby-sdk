require 'spec_helper'
module Metwit
  describe Metag do
    def metag
      factory = RGeo::Cartesian.factory
      
      options = {
        :weather => {:status => :sunny},
        :position => factory.point(1,2),
      }
      @metag ||= Metag.new(options)
    end

    context "valid metag" do
      it "should have a weather status != nil" do
        metag.should be_valid
        metag.weather[:status] = nil
        metag.should_not be_valid
      end

      it "should have a recognized weather status" do
        metag.should be_valid
        metag.weather[:status] = :vola_tutto
        metag.should_not be_valid
      end

      describe "#position" do
        it "should be != nil" do
          metag.should be_valid
          metag.position = nil
          metag.should_not be_valid
        end

        it "should be a geographical point" do
          metag.should be_valid
          gis = RGeo::Cartesian.factory
          metag.position = gis.line(gis.point(1,2), gis.point(2,1))
          metag.should_not be_valid
        end

        
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

    describe "::metag_from_json" do
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
        Metag.metag_from_json(response)
      end

      it "should return a metag with String id" do
        metag.id.should be_a String
      end

      it "should return a metag with Time timestamp" do
        metag.timestamp.should be_a Time
      end

      it "should return a metag with RGeo::Feature::Point position" do
        RGeo::Feature::Point.check_type(metag.position).should be_true
      end
      
      it "should return a metag with valid weather" do
        metag.weather[:status].should_not be_nil
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
