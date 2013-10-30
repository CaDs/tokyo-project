require 'database_cleaner'

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

FactoryGirl.definition_file_paths = [
  File.join(Padrino.root, 'factories'),
  File.join(Padrino.root, 'test', 'factories'),
  File.join(Padrino.root, 'spec', 'factories')
]
FactoryGirl.find_definitions


def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  TokyoProject.tap { |app|  }
end
