class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  attr_accessible :state, :friend_id, :user_id, :friend, :user
  
  after_save :update_friends_count
  after_destroy :update_friends_count
  
  scope :pending, -> { with_state(:pending) }
  scope :requested, -> { with_state(:requested) }
  scope :accepted, -> { with_state(:accepted) }
  
  state_machine do
    event :accept do
      transition [:requested, :pending] => :accepted
    end
    
    event :reject do
      transition [:requested, :pending] => :rejected
    end
    
    state :pending, :requested, :accepted, :rejected
  end
  
  def self.request(user_id, friend_id)
    if user_id == friend_id || Friendship.exists?(:user_id => user_id, :friend_id => friend_id)
      false
    else
      transaction do
        create :user_id => user_id, :friend_id => friend_id, :state => "pending"
        create :user_id => friend_id, :friend_id => user_id, :state => "requested"
      end
    end
  end
  
  def self.accept(user_id, friend_id)
    transaction do
      find_by_user_id_and_friend_id_and_state(user_id, friend_id, :pending).accept
      find_by_user_id_and_friend_id(friend_id, user_id, :requested).accept
    end
  end
  
  def self.reject(user_id, friend_id)
    transaction do
      find_by_user_id_and_friend_id_and_state(user_id, friend_id, "pending").reject
      find_by_user_id_and_friend_id_and_state(friend_id, user_id, "requested").reject
    end
  end
  
  private
  def update_friends_count
    transaction do
      user.friends_count = Friendship.where("user_id=? and state=?", user_id, "accepted").size
      friend.friends_count = Friendship.where("user_id=? and state=?", friend_id, "accepted").size
      user.save
      friend.save
    end
  end
  
end
