object false
if @saved
  node(:saved) { true }
  node(:message) { "Your album has been updated successfully." }
else
  node(:saved) { false }
  node(:message) { "There was sam problem while saving your changes." }
end
