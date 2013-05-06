class Participation < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  attr_accessible :album, :user, :album_id, :user_id
end
