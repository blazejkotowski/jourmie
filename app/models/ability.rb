class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # Album abilities
    can :manage, Album do |album|
      album.user_id == user.id || album.participants.include?(user)
    end
    
    # Place and road abilities
    can [:manage, :create], Place, :album => { :user_id => user.id }
    can [:manage, :create], Place do |place|
      place.album.participants.include?(user)
    end
    can [:manage, :create], Road, :album => { :user_id => user.id }
    can [:manage, :create], Road do |road|
      road.album.participants.include?(user)
    end
    
    # Content abilities
    can [:manage, :create], ContentPiece, :user_id => user.id 
    
    # Participations abilities
    can [:manage], Participation, :album => { :user_id => user.id }
    
  end
end
