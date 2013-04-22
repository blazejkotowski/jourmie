object @album
attributes :id, :name, :start_date, :end_date

node(:cover_image, :if => @album.cover_image.url.present?) { |album| album.cover_image.url }
