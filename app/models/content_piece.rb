class ContentPiece < ActiveRecord::Base
  attr_accessible :description, :file, :type, :place, :likes_count, :road_id,
                  :place_id, :user, :user_id, :remote_file_url, :comments_count
 
  belongs_to :place
  belongs_to :road
  belongs_to :user

  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable

  validates_presence_of :user_id,:type,:file
  validates_numericality_of :user_id, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :comments_count, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :likes_count, :only_integer => true, :greater_than_or_equal_to => 0

  validate :validate_type
  validate :any_present?

  def photoable
    road || place
  end

  def validate_type
    if(self.type)
      unless %w(music photo video).include?(self.type.downcase)
        errors.add(:type, "Type must be music, photo or video")
      end
    end
  end

  def any_present?
    if %w(road_id place_id).all?{|attr| self[attr].blank?}
      errors.add(:place_id,"ContentPiece has to be associated with a place or a road")
    end
  end

end
