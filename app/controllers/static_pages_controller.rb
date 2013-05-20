class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to profile_albums_url(current_user.profile.permalink)
    end
  end

  def about

  end

  def not_found
    render 'errors/error_404', :status => :not_found
  end

end
