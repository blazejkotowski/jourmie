object @photo
attributes :description
node(:file) { |photo| photo.file.url }
node(:params) { params }
