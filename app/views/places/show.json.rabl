object @place
attributes :id, :name, :date_from, :date_to, :latitude, :longitude

child({:road_from => :road_from}, :if => lambda { |place| place.road_from.present? }) { attributes :id }
child({:road_to => :road_to}, :if => lambda { |place| place.road_to.present? }) { attributes :id }
child(:photos, :if => lambda { |place| !place.photos.empty? }) { extends 'photos/show' }
