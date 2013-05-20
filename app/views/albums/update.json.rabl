object false
if @saved
  node(:saved) { true }
  node(:message) { "Your album has been updated successfully." }
  node(:url) { album_url(@album, :anchor => "show") }
else
  node(:saved) { false }
  node(:message) { "There was some problem while saving your changes." }
end

