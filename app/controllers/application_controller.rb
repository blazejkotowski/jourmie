class ApplicationController < ActionController::Base
  
  if Rails.env.production?  
    http_basic_authenticate_with :name => "memories", :password => "memories"
  end
  
  protect_from_forgery
  helper DeviseHelper

  unless Rails.env.test? || Rails.env.development?
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from ::AbstractController::ActionNotFound, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    rescue_from NoMethodError, :with => :render_500
  end
  
  def current_user
    @current_user ||= super && User.includes(:profile).find(@current_user.id)
  end
 
  def render_404(exception = nil)
    render :template => 'errors/error_404', :formats => [:html], :layout => true, :status => 404 and return
  end
 
  def render_500(exception = nil)
    render :template => 'errors/error_500', :formats => [:html], :layout => true, :status => 500 and return
  end

end
