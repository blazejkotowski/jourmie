class ContentPiece < ActiveRecord::Base
  attr_accessible :description, :file, :type, :place,
                  :place_id, :user, :user_id
  
  belongs_to :place
  belongs_to :user
  
end
