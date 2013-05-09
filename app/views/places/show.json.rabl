object @place
attributes :id, :name, :date_from, :date_to, :latitude, :longitude

child({:road_from => :road_from}, :if => lambda { |place| place.road_from.present? }) do
  extends 'roads/show'
end
child({:road_to => :road_to}, :if => lambda { |place| place.road_to.present? }) do
  extends 'roads/show'
end
child(:photos, :if => lambda { |place| !place.photos.empty? }) do
  extends 'photos/show'
end
