source 'https://rubygems.org'

# Padrino supports Ruby version 1.9 and later
# ruby '2.4.0'

# Distribute your app as a gem
# gemspec

# Server requirements
gem 'puma'

# Optional JSON codec (faster performance)
gem 'oj'

# Project requirements
gem 'rake'
gem 'padrino-cookies'
gem 'sinatra-flash', require: 'sinatra/flash'

# Component requirements
gem 'activerecord', '>= 3.1', require: 'active_record'
gem 'activesupport', '>= 3.1'
gem 'bcrypt'
gem 'erubis', '~> 2.7.0'
gem 'mysql2'

# Security
gem 'rack-protection'

# Cache
gem 'dalli', require: 'dalli'
gem 'memcachier', require: 'memcachier'

# Images
gem 'flickraw', require: 'flickraw'

# GeoStuff
gem 'geocoder'

gem 'kaminari'

# Test requirements
gem 'rack-test', require: 'rack/test', group: 'test'
gem 'rspec', group: 'test'

# Padrino Stable Gem
gem 'padrino', '0.13.3.3'
gem 'padrino-sprockets', require: ['padrino/sprockets']
# enable js minification
gem 'uglifier'
# enable css compression
gem 'yui-compressor'

group :development, :test do
  gem 'awesome_print'
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter', require: false
end
