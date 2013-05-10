class Road < ActiveRecord::Base

  MEANS = {
    :TRAIN => 0,
    :CAR => 1,
    :PLANE => 2,
    :HITCHHIKING => 3,
    :FOOT => 4,
    :BIKE => 5
  }

  attr_accessible :album_id, :place_from_id, :place_to_id, :album, :place_from,
                  :place_to, :means
  
  belongs_to :album
  has_one :place_from, :class_name => "Place", :foreign_key => "road_to_id"
  has_one :place_to, :class_name => "Place", :foreign_key => "road_from_id"
  has_many :photos

end
