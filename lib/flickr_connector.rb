# frozen_string_literal: true
class FlickrConnector
  def initialize
    # if Padrino.environment == :development
    #   config_file = File.join(File.dirname(__FILE__), '../config/flickr.yml')
    #   config = YAML.safe_load(File.read(config_file))
    #   ENV['FLICKR_API_KEY'] = config['api_key']
    #   ENV['FLICKR_SHARED_SECRET'] = config['shared_secret']
    #   ENV['FLICKR_ACCESS_TOKEN'] = config['access_token']
    #   ENV['FLICKR_ACCESS_SECRET'] = config['access_secret']
    # end

    FlickRaw.api_key = ENV['FLICKR_API_KEY']
    FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
  end

  def setup
    token = flickr.get_request_token
    auth_url = flickr.get_authorize_url(token['oauth_token'], perms: 'delete')

    puts "Open this url in your process to complete the authication process : #{auth_url}"
    puts 'Copy here the number given when you complete the process.'
    verify = gets.strip
    begin
      flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
      login = flickr.test.login
      puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"

      ENV['FLICKR_ACCESS_TOKEN'] = flickr.access_token
      ENV['FLICKR_ACCESS_SECRET'] = flickr.access_secret
    rescue FlickRaw::FailedResponse => e
      puts "Authentication failed : #{e.msg}"
    end
  end

  def upload(image, title, description)
    flickr.upload_photo(image[:tempfile].path, title: title, description: description)
  end

  def get_picture(image_id)
    flickr.photos.getInfo(photo_id: image_id)
  end
end
