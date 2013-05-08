class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :text, :user_id

  belongs_to :commentable, :class_name => "ContentPiece", :counter_cache => true, :polymorphic => true
  belongs_to :user

  default_scope order(:created_at)
end
