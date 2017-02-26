require 'active_support/core_ext/object/blank'

module TokyoProjectng
  class Admin < Padrino::Application
    use ConnectionPoolManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl
    register Padrino::Sprockets
    sprockets minify: true

    set :cache, Padrino::Cache.new(:Memcached, backend: ::Dalli::Client.new)

    ##
    # Application configuration options
    #
    # set :raise_errors, true         # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true          # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true      # Shows a stack trace in browser (default for development)
    # set :logging, true              # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, "foo/bar"   # Location for static assets (default root/public)
    # set :reload, false              # Reload application files (default in development)
    # set :default_builder, "foo"     # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, "bar"         # Set path for I18n translations (default your_app/locales)
    # disable :sessions               # Disabled sessions by default (enable if needed)
    # disable :flash                  # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout              # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    set :admin_model, 'Account'
    set :login_page,  '/sessions/new'

    enable  :sessions
    disable :store_location

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :admin do |role|
      role.project_module :posts, '/posts'
    role.project_module :pictures, '/pictures'
    role.project_module :visions, '/visions'
    role.project_module :areas, '/areas'
    role.project_module :wards, '/wards'
    role.project_module :accounts, '/accounts'
    end

    # Custom error management
    error(403) { @title = 'Error 403'; render('errors/403', layout: :error) }
    error(404) { @title = 'Error 404'; render('errors/404', layout: :error) }
    error(500) { @title = 'Error 500'; render('errors/500', layout: :error) }
  end
end
