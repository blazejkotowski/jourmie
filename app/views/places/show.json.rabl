object @place
attributes :id, :name, :date_from, :date_to, :latitude, :longitude

child(:road_from, :if => lambda { |place| place.road_from.present? }) { attributes :id }
child(:road_to, :if => lambda { |place| place.road_to.present? }) { attributes :id }
