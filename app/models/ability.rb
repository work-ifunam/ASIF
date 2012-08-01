class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new 
    if user.category == "Chuck Norris"
      can :manage, User
    elsif user.category == "Admin COMPUTO" || user.category == "Admin ELECTRONICA"
      can :manage, Category
      can :manage, Assignation          
    elsif user.category == "Personal COMPUTO" || user.category == "Personal ELECTRONICA"
      can :manage, Category
    else
      can :read, :all
    end
  end
  
end
