if @album.new_record?
  node(:error) { @album.errors }
else
  object @album
  extends 'albums/show'
  node(:saved) { true }
  node(:message) { "Your album has been created successfully" }
  node(:url) { album_url(@album, :anchor => "show") }
end
