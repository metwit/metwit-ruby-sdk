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

# Set your client_id and client secret. See http://metwit.com/developers
Metwit.client_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Metwit.client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Metwit.get_access_token

# To retrieve the current weather status and forecasts for a geographical point
Metwit::Weather.in_location(latitude, longitude)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
