class FriendshipsController < ApplicationController
  respond_to :json, :html
  
  def create
    @created = Friendship.request(current_user.id, params[:friend_id])
  end
  
  def accept
    Friendship.accept(current_user.id, params[:friend_id])
  end
  
  def reject
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:friendship_id])
    @freindship.destroy
  end
  
end
