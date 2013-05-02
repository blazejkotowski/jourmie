class UserProfilesController < ApplicationController
  before_filter :authenticate_user!, :load_current_user_profile, :only => [:edit, :update]
  before_filter :load_user_profile, :only => [:show]
  
  def edit
    
  end

  def update
    @profile.update_attributes(params[:user_profile])
    render "edit"
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
