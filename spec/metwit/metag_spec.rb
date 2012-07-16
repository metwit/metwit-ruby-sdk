require 'spec_helper'

module Metwit
  describe Metag do
    def metag
      @metag ||= Metag.new(:weather => {:status => :sunny}, :position => 'suca')
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
          pending
        end

        
      end
            
    end
    
  end
end
