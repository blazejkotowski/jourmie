class FriendshipsController < ApplicationController
  respond_to :json, :html
  
  def create
    @created = Friendship.request(current_user.id, params[:friend_id].to_i)
  end
  
  def accept
    friend = UserProfile.find_by_permalink(params[:profile_id]).user
    Friendship.accept(friend.id, current_user.id)
    respond_to do |format| 
      format.html { redirect_to profile_friendships_url(current_user.profile.permalink) }
      format.json
    end
  end
  
  def reject
    friend = UserProfile.find_by_permalink(params[:profile_id]).user
    Friendship.reject(friend.id, current_user.id)
    respond_to do |format| 
      format.html { redirect_to profile_friendships_url(current_user.profile.permalink) }
      format.json
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    Friendship.delete(@friendship)
    redirect_to profile_friendships_url(current_user.profile.permalink)
  end
  
  def index
    if params[:profile_id] == current_user.profile.permalink
      @owner = true
      @friendships = current_user.friendships.displayable.order(:state)
    else
      @owner = false
      @friendships = UserProfile.find_by_permalink(params[:profile_id]).user.friendships.accepted
    end
    if request.xhr?
      render :layout => false
    end
  end
  
end
