class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # Album abilities
    can :read, Album do |album|
      album.user_id == user.id || album.participants.include?(user)
    end
    
    can :manage, Album, :user_id => user.id
    
    # Place and road abilities
    can :manage, Place, :album => { :user_id => user.id }
    can :manage, Road, :album => { :user_id => user.id }
    
    can :create, Place, :album => { :user_id => user.id }
    can :create, Road, :album => { :user_id => user.id }
    
    # Content abilities
    can [:manage, :create], ContentPiece, :user_id => user.id 
    
  end
end
