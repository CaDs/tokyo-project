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
    cache_key  'root_path'
    expires_in(Padrino.env.to_s == "production" ? 3600 : 100)
    @visions = Vision.last(3)
    render 'layouts/landing'
  end

  get '/about' do
    render 'layouts/about'
  end

  require 'builder'
  get '/sitemap', :provides => [:xml], :cache => true do
    cache_key 'sitemap'
    expires_in(Padrino.env.to_s == "production" ? 3600 : 100)

    static_pages = [uri(url("/")), uri(url("/about"))]
    areas = Area.all.collect{|area| uri url(:areas, :show, id: "#{area.id}")}
    visions = Vision.all.collect{|vision| uri url(:visions, :show, id: "#{vision.id}")}
    pictures = Picture.all.collect{|picture| uri url(:visions, :show, id: "#{picture.vision.id}", pid: picture.id)}
    @urls = static_pages + areas + visions + pictures

    xml = Builder::XmlMarkup.new(:target =>"", :indent => 2)
    xml.instruct! :xml, :encoding => "UTF-8"
    xml.urlset(
      'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
      'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
    )do
      @urls.each do |url|
        xml.url do |url_tag|
          url_tag.loc url
          url_tag.changefreq "hourly"
        end
      end
    end
    xml
  end
end
