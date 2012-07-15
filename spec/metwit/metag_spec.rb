require 'spec_helper'

module Metwit
  describe Metag do
    def metag
      @metag ||= Metag.new
    end

    it "must have a weather status" do
      metag.weather[:status] = nil
      metag.should_not be_valid
    end
  end
end
