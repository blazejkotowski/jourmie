class UserProfile < ActiveRecord::Base
  attr_accessible :birthday, :first_name, :phone, :sex, :last_name, :user_id,
                  :avatar, :remote_avatar_url
  
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  
end
