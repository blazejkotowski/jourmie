object @profile
attributes :id, :permalink, :full_name, :display_name

node :avatar do |profile|
  {
    :small => profile.avatar.url(:small),
    :medium => profile.avatar.url(:medium)    
  }
end

node(:add_friend_path) { |profile| friendships_path(:friend_id => profile.user.id) }

if @profile.user == current_user
  node(:current_user) { true }
  node(:edit_profile_path) { edit_profile_path }
end

child :user do
  attributes :albums_count, :friends_count
  child :albums do
    extends 'albums/show'
    node(:url) { |album| album_path(album) }
  end
end
