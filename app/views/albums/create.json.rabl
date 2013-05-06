if @album.new_record?
  node(:error) { @album.errors }
else
  object @album
  attributes :id, :name, :start_date, :end_date, :user_id
end
