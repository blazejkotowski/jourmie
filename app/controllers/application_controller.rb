class ApplicationController < ActionController::Base
  
  if Rails.env.production?  
    http_basic_authenticate_with :name => "memories", :password => "memories"
  end
  
  protect_from_forgery
  helper DeviseHelper
  
end
