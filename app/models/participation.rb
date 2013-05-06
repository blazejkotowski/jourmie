class Participation < ActiveRecord::Base
  belongs_to :album, :counter_cache => true
  belongs_to :user
  attr_accessible :album, :user, :album_id, :user_id
end
