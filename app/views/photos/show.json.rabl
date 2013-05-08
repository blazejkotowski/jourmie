object @photo
attributes :id, :description, :comments_count, :created_at
node(:thumb) { |photo| photo.file.url(:big_thumb) }
node(:file) do |photo|
  {
    :thumb => photo.file.url(:big_thumb),
    :original => photo.file.url
  }
end
child(:user) { extends 'devise/registrations/basic' }
child(:comments) do
  extends 'comments/index'
end
