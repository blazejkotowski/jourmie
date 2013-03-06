class Album < ActiveRecord::Base
  extend FriendlyId
  
  mount_uploader :cover_image, AlbumCoverUploader
  
  friendly_id :name, :use => :slugged
  
  attr_accessible :cover_image, :end_date, :name, :start_date, :user_id
  
  belongs_to :user
  has_many :participants, :class_name => "User"
  
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :name
  validates_presence_of :user_id
  
  
end
