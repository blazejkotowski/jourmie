object @friendship
attributes :id, :state, :user_id, :friend_id

node(:add_friend_path) { |f| friendships_path(:friend_id => f.friend_id) }
node(:delete_friendship_path) { |f| friendship_path(f) }
node(:accept_friendship_path) { |f| accept_profile_friendships_path(f.friend.profile.permalink) }

child :friend => :friend do |friend|
  node(:profile_path) { show_profile_path(friend) }
  child :profile => :profile do 
    attribute :display_name
    node(:avatar) do |profile|
      { :small => profile.avatar.url(:small), :tiny => profile.avatar.url(:tiny) }
    end
  end
end
