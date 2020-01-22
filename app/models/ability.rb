class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new 
    if user.category == "Chuck Norris"
      can :manage, User
      can :manage, Technician
    elsif user.category == "Admin COMPUTO" || user.category == "Admin ELECTRONICA" || user.category == "Admin TALLER"  || user.category == "Admin COMUNICACION" 
      can :manage, Category
      can :manage, Assignation          
      can :manage, Assignment          
    elsif user.category == "Personal COMPUTO" || user.category == "Personal ELECTRONICA"
      can :manage, Category
    else
      can :read, :all
    end
  end
  
end
