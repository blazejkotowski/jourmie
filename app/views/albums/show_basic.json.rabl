object @album
attributes :id, :name, :start_date, :end_date, :cover_image, :slug, :places_count, :participations_count
node(:url) { |album| album_path(album) }
node(:start_date_string) { |album| album.start_date.strftime("%d.%m.%Y") }
node(:end_date_string) { |album| album.end_date.strftime("%d.%m.%Y") }
