object @photo
attributes :id, :description
node(:file) { |photo| photo.file.url(:big_thumb) }
