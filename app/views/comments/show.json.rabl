object @comment
attributes :id, :commentable_id, :text, :created_at
child(:user) { extends 'devise/registrations/basic' }
