require 'uri'

class Album < ActiveRecord::Base
  extend FriendlyId
  
  mount_uploader :custom_cover_image, AlbumCoverUploader
  
  friendly_id :name, :use => :slugged
  
  attr_accessible :end_date, :name, :start_date, :user_id,
                  :cover_image
  
  belongs_to :user
  has_many :participants, :class_name => "User"
  has_many :places
  has_many :roads
  
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :name
  validates_presence_of :user_id
  
  def cover_image
    if custom_cover_image.url.present?
      custom_cover_image.url
    else
      "/assets/covers/cover#{jourmie_cover_image}.jpg"
    end
  end
  
  def cover_image= (path)
    if URI.parse(path).scheme == "http"
      custom_cover_image.url = path
    else
      id = path[/\/assets\/covers\/cover([0-9]+)\.jpg/, 1]
#      update_attribute :jourmie_cover_image, id
      write_attribute :jourmie_cover_image, id
    end
  end
  
end
