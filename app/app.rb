class TokyoProject < Padrino::Application
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Cookies
  register Padrino::Cache
  register Padrino::Flash

  enable :sessions

  # Caching support
  enable :caching
  set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new)

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #
  # disable :raise_errors
  # disable :show_exceptions

  ##
  # You can configure for a specified environment like:
  #
  configure :production do
    require 'newrelic_rpm'
  end

  not_found do
    @message = "Woops that doesn't seems to exist"
    render 'layouts/error', :layout => false
  end

  error 400..510 do
    @message = "Woa woa stop there!"
    render 'layouts/error', :layout => false
  end

  get '/', :cache => true do
    expires_in 1 #Caching for 5 minutes
    @visions = Vision.last(3)
    render'layouts/landing'
  end

  get '/about' do
    render'layouts/about'
  end
end
