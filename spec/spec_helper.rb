require 'rubygems'
require 'bundler/setup'

require 'metwit'
require 'webmock/rspec'

RSpec::Matchers.define :be_boolean do
  match do |value|
    value.is_a?(TrueClass) or value.is_a?(FalseClass)
  end
end


WebMock.allow_net_connect!

def fixture(filename)
  open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename.to_s}"))
end
