object @road
attributes :id

child(:photos, :if => lambda { |road| !road.photos.empty? }) do
  extends 'photos/show'
end
