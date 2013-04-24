class Road < ActiveRecord::Base
  attr_accessible :album_id, :place_from_id, :place_to_id, :album, :place_from,
                  :place_to
  
  belongs_to :album
  belongs_to :place_from
  belongs_to :place_to
end
