class UserProfilesController < ApplicationController
  before_filter :authenticate_user!, :load_current_user_profile, :only => [:edit, :update]
  before_filter :load_user_profile, :only => [:show]

  include ApplicationHelper
  
  def edit
    
  end

  def update
    if @profile.update_attributes(params[:user_profile])
      redirect_to show_profile_path(@profile.user)
    else
      render "edit"
    end
  end
  
  def show
    
  end
  
  private
  def load_current_user_profile
    @profile = current_user.profile
  end
  
  def load_user_profile
    @profile = UserProfile.find_by_permalink(params[:id])
  end
  
end
