# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.0'
# Padrino supports Ruby version 1.9 and later

# Distribute your app as a gem
# gemspec

# Server requirements
gem 'bundler'
gem 'foreman'
gem 'puma'

# Optional JSON codec (faster performance)
gem 'oj'

# Project requirements
gem 'padrino-cookies'
gem 'rake'
gem 'sinatra-flash', require: 'sinatra/flash'

# Component requirements
gem 'activerecord', '>= 3.1', require: 'active_record'
gem 'activesupport', '>= 3.1'
gem 'bcrypt'
gem 'erubi'
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
gem 'kaminari-sinatra'

gem 'dotenv'

# Test requirements
gem 'rack-test', require: 'rack/test', group: 'test'
gem 'rspec', group: 'test'

# Padrino Stable Gem
gem 'padrino'
gem 'padrino-sprockets', require: ['padrino/sprockets']
# enable js minification
gem 'uglifier'
# enable css compression
gem 'yui-compressor'

gem 'newrelic_rpm'

gem 'builder'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'rubocop',  require: false
  gem 'rubocop-checkstyle_formatter', require: false
end
