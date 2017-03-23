# frozen_string_literal: true
module TokyoProject
  class App < Padrino::Application
    use ConnectionPoolManagement
    use Rack::Deflater
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Cookies
    register Padrino::Cache
    register Padrino::Flash
    register Padrino::Cache
    register Padrino::Sprockets
    sprockets minify: false

    set :cache, Padrino::Cache.new(:Memcached, backend: ::Dalli::Client.new)
    enable :caching

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #
    configure :production do
      require 'newrelic_rpm'
    end

    not_found do
      @message = "Woops that doesn't seems to exist"
      render 'layouts/error', layout: false
    end

    error 400..510 do
      @message = 'Woa woa stop there!'
      render 'layouts/error', layout: false
    end

    get '/', cache: true do
      cache_key 'root_path'
      expires(Padrino.env.to_s == 'production' ? 86_400 : 1)
      latest_visions = Picture.published
                              .select('vision_id')
                              .order('created_at DESC')
                              .pluck(:vision_id)
                              .uniq
                              .first(3)
      @visions = Vision.preload(:pictures)
                       .find(latest_visions)
      render 'layouts/landing'
    end

    get '/new_landing', cache: true do
      cache_key 'new_landing'
      expires(Padrino.env.to_s == 'production' ? 86_400 : 1)
      @latest_visions = Picture.published
                               .order('created_at DESC')
                               .collect(&:vision_id)
                               .uniq
                               .first(10)
                               .collect { |id| Vision.find(id) }
      render 'layouts/new_landing', layout: false
    end

    get '/about' do
      render 'layouts/about'
    end

    require 'builder'
    get '/sitemap', provides: [:xml] do
      static_pages = [uri(url('/')), uri(url('/about')), uri(url(:areas, :index)), uri(url(:visions, :index))]
      areas = Area.find_each.collect { |area| uri url(:areas, :show, id: area.url_title.to_s) }
      visions = Vision.find_each.collect { |vision| uri url(:visions, :show, id: vision.url_title.to_s) }
      posts = Post.find_each.collect { |post| uri url(:blog, :show, id: post.id.to_s) }
      @urls = static_pages + areas + visions + posts
      render 'layouts/sitemap'
    end
  end
end
