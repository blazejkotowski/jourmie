class Comment < ActiveRecord::Base
  attr_accessible :commentable, :commentable_id, :text, :user

  belongs_to :commentable, :counter_cache => true
  belongs_to :user

  default_scope order(:created_at)
end
