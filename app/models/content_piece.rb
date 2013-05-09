class ContentPiece < ActiveRecord::Base
  attr_accessible :description, :file, :type, :place, :likes_count,
                  :place_id, :user, :user_id, :remote_file_url, :comments_count
 
  belongs_to :place
  belongs_to :user

  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable

end
