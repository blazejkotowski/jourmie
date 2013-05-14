require 'uri'

class Album < ActiveRecord::Base
  extend FriendlyId
  
  mount_uploader :custom_cover_image, AlbumCoverUploader
  
  friendly_id :name, :use => :slugged
  
  attr_accessible :end_date, :name, :start_date, :user_id, :places_count,
                  :cover_image, :participations, :participations_count,
                  :user
  
  belongs_to :user, :counter_cache => true
  
  has_many :participations, :dependent => :destroy
  has_many :participants, :through => :participations, :source => :user
  
  has_many :places, :dependent => :destroy
  has_many :roads, :dependent => :destroy
  
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
  
  def participants_profiles
    (participants + [user]).map { |participant| participant.profile} 
  end
  
end
