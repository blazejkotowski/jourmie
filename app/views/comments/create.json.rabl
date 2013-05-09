if @comment.new_record?
  node(:error) { "There was some problem while creating new comment" }
else
  object @comment 
  extends 'comments/show'
end
