object @user
child :profile => :profile do |profile|
  attribute :display_name
  node(:url) { show_profile_url(profile.user) }
  node :avatar do |profile|
    { 
      :big => profile.avatar.url(:big),
      :small => profile.avatar.url(:small),
      :tiny => profile.avatar.url(:tiny) 
    }
  end
end
