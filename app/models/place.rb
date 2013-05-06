class Place < ActiveRecord::Base
  attr_accessible :album_id, :date_from, :date_to, :latitude, :longitude, 
                  :name, :road_from_id, :road_to_id
                  
  belongs_to :album, :counter_cache => true
  has_one :road_to, :class_name => "Road", :foreign_key => "place_from_id"
  has_one :road_from, :class_name => "Road", :foreign_key => "place_to_id"
  has_many :photos
  
end
