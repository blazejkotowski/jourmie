object @album
attributes :id, :name, :start_date, :end_date, :cover_image

child(:places) do
  extends 'places/show'
end
