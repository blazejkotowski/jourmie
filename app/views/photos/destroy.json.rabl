object false
unless @success
  node(:error) { "There was some problem while deleting your photo." }
end
