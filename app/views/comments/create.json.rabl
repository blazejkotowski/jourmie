if @comment.new_record?
  node(:error) { "There was some problem while creating new comment" }
else
  object @comment 
  attributes :id, :content_piece_id, :text, :title, :user_id
end
