# Metwit

http://metwit.com

## Installation

Add this line to your application's Gemfile:

    gem 'metwit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metwit

## Usage

```ruby
# First require the gem
require 'metwit'

# Set your api key
Metwit.api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

## How to post a Metag
# If you don't authenticate a user you may not be able to post metags
Metwit.authenticate("username", "password")
# You need a rgeo factory to project the point coordinates
factory = RGeo::Cartesian.factory
# Then you can create a basic metag
metag = Metwit::Metag.new(
      :weather => {:status => :clear},
      :position => factory.point(45.4, 9.1)
)
# Then post it to the server
metag.create!

## How to get a user by id
user = Metwit::User.find('id')

## How to get a metag by id
metag = Metwit::Metag.find('id')

## How to get metags in a geographical region
metags = Metwit::Metag.in_rect(45.4, 9.1, 45.3, 9.0)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
