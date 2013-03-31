class FacebookConnector

  def initialize
    if TokyoProject.environment == :development
      config_file = File.join(File.dirname(__FILE__), "../config/facebook_config.yml")
      config = YAML.load(File.read(config_file))[Padrino.env.to_s]
      ENV['FACE_APP_KEY'] = config['app_key'].to_s
      ENV['FACE_APP_SECRET'] = config['app_secret'].to_s
      ENV['FACE_APP_REDIRECT'] = config['app_redirect'].to_s
    end
    @user_connector = Koala::Facebook::OAuth.new(ENV['FACE_APP_KEY'], ENV['FACE_APP_SECRET'], ENV['FACE_APP_REDIRECT'])
  end

  def user_connector
    @user_connector
  end

  def self.get_like_count(url)
    api = Koala::Facebook::API.new()
    fql_query = "SELECT url, share_count, like_count, comment_count, total_count FROM link_stat WHERE url='#{url}'";
    likes = api.fql_query(fql_query).first['like_count'] rescue 0
  end

end