class Place < ActiveRecord::Base
  attr_accessible :album_id, :date_from, :date_to, :latitude, :longitude, 
                  :name, :road_from_id, :road_to_id
                  
  belongs_to :album
  has_one :road_to
  has_one :road_from
  
end
