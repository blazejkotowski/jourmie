class UserProfile < ActiveRecord::Base
  attr_accessible :birthday, :first_name, :phone, :sex, :last_name, :user_id,
                  :avatar, :remote_avatar_url, :permalink
  
  validates_format_of :permalink, :with => /^[a-zA-Z0-9-]+$/, :allow_blank => true, :allow_nil => true
  validates_uniqueness_of :permalink, :allow_blank => true, :allow_nil => true
  
  validates_presence_of :last_name
  validates_presence_of :first_name  
  validates_format_of :phone, :with => /^[0-9-]+$/, :allow_blank => true, :allow_nil => true
  validates_inclusion_of :sex, :in => ["male", "female"]
  
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  
  before_save :set_permalink
  
  def full_name
    unless first_name.blank? && last_name.blank?
      "#{first_name} #{last_name}"
    end
  end
  
  def display_name
    if full_name.nil?
      user.email
    else
      full_name
    end
  end
  
  private
  def set_permalink
    if permalink.empty?
      i = 1
      link = full_name.parameterize
      if UserProfile.find_by_permalink(link).present?
        while UserProfile.find_by_permalink("#{link}-#{i}").present? do
          i += 1
        end
      end
      write_attribute :permalink, "#{link}-#{i}"
    end
  end
  
end
