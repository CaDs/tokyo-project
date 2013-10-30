source 'https://rubygems.org'

ruby '2.0.0'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'will_paginate', '~>3.0'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'erubis', "~> 2.7.0"
gem 'activerecord', :require => "active_record"
gem 'mysql2'

# Test requirements
gem 'rspec', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"
gem 'factory_girl', :group => "test"
gem 'database_cleaner', :group => "test"

gem 'tilt', '1.3.7'

# Padrino Stable Gem
gem 'padrino', '0.11.1'
gem 'padrino-cookies'
gem 'padrino-flash'

#Security
gem 'rack-protection'

#Cache
gem 'memcachier', :require => 'memcachier'
gem 'dalli', :require => 'dalli'

#Images
gem 'flickraw', :require => 'flickraw'

#GeoStuff
gem "geocoder"

#Debugger
group :development, :test do
  gem "debugger"
  gem "cucumber"
  gem "capybara"
end

#Performance
gem 'padrino-rpm', :git => 'https://github.com/Asquera/padrino-rpm.git'