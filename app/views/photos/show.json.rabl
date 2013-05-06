object @photo
attributes :id, :description
node(:thumb) { |photo| photo.file.url(:big_thumb) }
node(:file) do |photo|
  {
    :thumb => photo.file.url(:big_thumb),
    :original => photo.file.url
  }
end
