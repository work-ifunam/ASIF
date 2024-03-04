class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new 
    if user.category == "Chuck Norris"
      can :manage, User
      can :manage, Technician
      can :manage, Category
      can :manage, Assignation          
      can :manage, Assignment          
      can :manage, Score
      can :manage, Ticket
    elsif user.category == "Admin COMPUTO" || user.category == "Admin ELECTRONICA" || user.category == "Admin TALLER"  || user.category == "Admin COMUNICACION" || user.category == "Admin MANTENIMIENTO" || user.category == "Admin SERVICIOS" || user.category == "SAC"
      can :manage, Category
      can :manage, Assignation          
      can :manage, Assignment          
    elsif user.category == "Personal COMPUTO" || user.category == "Personal ELECTRONICA"
      can :manage, Category
    else
      can :read, :all
      can :create, Score
    end
  end
  
end
