class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauth_providers => [:facebook, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :uid, :provider, :name
                  
  has_one :profile, :class_name => "UserProfile", :dependent => :destroy
  accepts_nested_attributes_for :profile
  
  before_create :add_profile
  
  
  def self.from_omniauth(auth)
    if auth.provider == "facebook"
      from_facebook_provider(auth)
    else
      from_other_provider(auth)
    end
  end
  
  def self.from_facebook_provider(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.update_attributes auth.slice(:provider,:uid).merge({:email => auth.info.email})
      user.build_profile(auth.info.slice(:first_name, :last_name).merge({ :remote_avatar_url => auth.info.image }))
      bp = auth.extra.raw_info.birthday.split('/')
      user.profile.birthday = "#{bp[1]}-#{bp[0]}-#{bp[2]}".to_date
      user.profile.sex = auth.extra.raw_info.gender
    end
  end
  
  def self.from_other_provider(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.update_attributes auth.slice(:provider,:uid).merge({:email => auth.info.email})
      names = auth.info.name.split
      name = names.try("[]", 0); surname = names.try("[]", 1)
      user.build_profile({ :first_name => name, :last_name => surname }.merge({ :remote_avatar_url => auth.info.image }))
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"].present?
      new(session["devise.user_attributes"], :without_protection => true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super and provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  
  private
  
  def add_profile
    build_profile unless profile.present?
  end
  
end
