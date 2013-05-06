if @album.new_record?
  node(:error) { @album.errors }
else
  object @album
  extends 'albums/show'
end
