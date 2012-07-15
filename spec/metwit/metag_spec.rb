require 'spec_helper'

module Metwit
  describe Metag do
    def metag
      @metag ||= Metag.new(:weather => {:status => :sunny}, :geo => 'suca')
    end

    context "valid metag" do
      it "must have a weather status" do
        metag.weather[:status] = nil
        metag.should_not be_valid
      end

      it "must have a recognized weather status" do
        metag.weather[:status] = :vola_tutto
        metag.should_not be_valid

        metag.weather[:status] = :sunny
        metag.should be_valid
      end

      it "must have a geo location" do
        metag.geo = nil
        metag.should_not be_valid
      end
      
    end
    
  end
end
