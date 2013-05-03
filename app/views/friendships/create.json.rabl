if @created
  node(:message) { "Successfully requested for a friendship." }
else
  node(:error) { "There was some error while creating new friendship." }
end

