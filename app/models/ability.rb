class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # Album abilities
    can :read, Album do |album|
      album.user_id == user.id || album.participants.include?(user)
    end
    
    can [:update, :destroy], Album, :user_id => user.id
    
    # Place and road abilities
    can :create, Place, :album => { :user_id => user.id }
    can :create, Road, :album => { :user_id => user.id }
    
  end
end
