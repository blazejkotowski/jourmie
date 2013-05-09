class Road < ActiveRecord::Base
  attr_accessible :album_id, :place_from_id, :place_to_id, :album, :place_from,
                  :place_to
  
  belongs_to :album
  has_one :place_from, :class_name => "Place", :foreign_key => "road_to_id"
  has_one :place_to, :class_name => "Place", :foreign_key => "road_from_id"
  has_many :photos

end
