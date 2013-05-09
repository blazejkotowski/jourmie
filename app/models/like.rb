class Like < ActiveRecord::Base
  attr_accessible :likeable_id, :likeable_type, :user_id

  belongs_to :likeable, :polymorphic => true, :class_name => "ContentPiece", :counter_cache => true
  belongs_to :user
end
