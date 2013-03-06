class ApplicationController < ActionController::Base
  
  if Rails.env.production?  
    http_basic_authenticate_with :name => "memories", :password => "memories"
  end
  
  protect_from_forgery
  helper DeviseHelper
  
  def current_user
    @current_user ||= super && User.includes(:profile).find(@current_user.id)
  end
  
end
