object @user
child :profile => :profile do
  node :avatar do |profile|
    { 
      :big => profile.avatar.url(:big),
      :small => profile.avatar.url(:small),
      :tiny => profile.avatar.url(:tiny) 
    }
  end
end
