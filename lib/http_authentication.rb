module HttpAuthentication
  module Basic
    def authenticate_or_request_with_http_basic(realm = 'Application')
      authenticate_with_http_basic || request_http_basic_authentication(realm)
    end

    def authenticate_with_http_basic
      if auth_str = request.env['HTTP_AUTHORIZATION']
        logger.info("---------------------------AUth REQUEST: #{request.env['HTTP_AUTHORIZATION']}---------------------------")
        if Padrino.env.to_s == "production"
          return "#{ENV["BASIC_AUTH_NAME"]}:#{ENV["BASIC_AUTH_PW"]}" == Base64.decode64(auth_str.sub(/^Basic\s+/, ''))
        else
          return true
        end
      end
    end

    def request_http_basic_authentication(realm = 'Application')
      response.headers["WWW-Authenticate"] = %(Basic realm="Application")
      response.body = "HTTP Basic: Access denied.\n"
      response.status = 401
      return false
    end
  end
end