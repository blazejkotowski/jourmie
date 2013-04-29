object @photo
attributes :description
node(:file) { |photo| photo.file.url(:big_thumb) }
node(:params) { params }
