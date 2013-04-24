object @album
attributes :id, :name, :start_date, :end_date, :cover_image

child(:places) do
  attributes :id, :name, :date_from, :date_to, :latitude, :longitude
end

child(:roads) do
  attributes :id
end
