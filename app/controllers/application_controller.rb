class ApplicationController < ActionController::Base
  protect_from_forgery

   def authenticate_htaccess
    if Rails.env == 'production'
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "eforogt"
      end
    else
      return true
    end
  end
end
