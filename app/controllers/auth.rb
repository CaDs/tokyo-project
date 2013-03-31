TokyoProject.controllers :auth do
  before do
    f_connector = FacebookConnector.new
    @user_connector = f_connector.user_connector
  end

  get :start do
    if cookies[:u_info]
      #If the cookie is set we are supposed to have all the information required so we can skip the auth
      redirect url(:site, :index)
    else
      #Start the oauth protocol
      redirect(@user_connector.url_for_oauth_code)
    end
  end

  get :callback do
    begin
      code = params[:code]
      access_token = @user_connector.get_access_token(code)

      #storing the access token just in case
      cookies[:access_token] = access_token

      graph = Koala::Facebook::API.new(access_token)
      #Get all info we might need from graph api and store it inside a cookie
      user_info = graph.get_object("me")
      user_info["profile_picture"] = graph.get_picture("me")
      account = Account.create_user_accounf_from_facebook(user_info)
      cookies[:u_info] = user_info.to_json
      redirect url(:site, :index)
    rescue Exception => e
      flash[:error] = "There was an error on your authentication, please try again."
      logger.error("Error Authenticating User #{e.message}")
    ensure
      redirect url(:site, :index)
    end
  end
end
