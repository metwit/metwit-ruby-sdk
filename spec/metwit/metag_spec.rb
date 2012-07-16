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
    
  end
end
