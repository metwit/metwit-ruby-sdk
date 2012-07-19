require 'rubygems'
require 'bundler/setup'

require 'metwit'
require 'webmock/rspec'

WebMock.allow_net_connect!

def fixture(filename)
  open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename.to_s}"))
end
