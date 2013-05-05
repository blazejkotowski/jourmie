class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to profile_albums_url(current_user.profile.permalink)
    end
  end
end
