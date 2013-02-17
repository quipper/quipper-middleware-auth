# Quipper::Middleware::Auth


## Installation

Add this line to your application's Gemfile:

    gem 'dalli'
    gem 'omniauth-google-apps'
    gem 'quipper-middleware-auth', :git => "https://github.com/quipper/quipper-middleware-auth.git"

And then execute:

    $ bundle

## Usage

```
  require 'openid/store/memcache'
  require 'omniauth/strategies/google_apps'

  use Rack::Session::Cookie, :secret => 'heflah4b2mhzsoirlh23kjrhkjshfglkq23j5kjbvaoiaksjdh'
  
  use OmniAuth::Builder do
    provider :google_apps, :store => OpenID::Store::Memcache.new(Dalli::Client.new), :name => 'g', :domain => 'quipper.com'
  end

  use Quipper::Middleware::Auth::GoogleApps, :name => 'g'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
