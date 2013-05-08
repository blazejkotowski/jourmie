class ContentPiece < ActiveRecord::Base
  attr_accessible :description, :file, :type, :place,
                  :place_id, :user, :user_id, :remote_file_url
 
  belongs_to :place
  belongs_to :user

  has_many :comments, :as => :commentable

end
