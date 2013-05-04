class FriendshipsController < ApplicationController
  respond_to :json, :html
  
  def create
    @created = Friendship.request(current_user.id, params[:friend_id].to_i)
  end
  
  def accept
    Friendship.accept(current_user.id, params[:friend_id].to_i)
  end
  
  def reject
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:friendship_id])
    @freindship.destroy
  end
  
  def index
    if params[:profile_id] == current_user.profile.permalink
      @friendships = current_user.friendships
    else
      @friendships = UserProfile.find_by_permalink(params[:profile_id]).user.friendships.accepted
    end
  end
  
end
