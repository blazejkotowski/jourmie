collection @comments
attributes :text, :created_at
child(:user) { extends 'devise/registrations/basic' }
