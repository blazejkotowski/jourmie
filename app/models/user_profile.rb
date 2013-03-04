class UserProfile < ActiveRecord::Base
  attr_accessible :birthday, :first_name, :phone, :sex, :last_name, :user_id,
                  :avatar, :remote_avatar_url, :permalink
  
  validates_format_of :permalink, :with => /^[a-zA-Z0-9-]+$/, :allow_blank => true, :allow_nil => true
  validates_uniqueness_of :permalink, :allow_blank => true, :allow_nil => true
  
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  
end
