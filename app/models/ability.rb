class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new 
    #if user.category == "Chuck Norris"
    if user.category == "Chuck Norris" || user.id == 169
      can :manage, User
      can :manage, Technician
      can :manage, Category
      can :manage, Assignation          
      can :manage, Assignment          
      can :manage, Score
      can :manage, Ticket
    elsif user.category == "Admin COMPUTO" || user.category == "SAC" || user.category == "Sec COMPUTO" || user.category == "Dirección"
      can :read, :show_computer_tickets
      #cannot :read, :show_workshop_tickets
    elsif user.category == "Admin TALLER"  || user.category == "SAC" || user.category == "Sec COMPUTO" || user.category == "Dirección"
      can :read, :show_workshop_tickets
    elsif user.category == "Admin MANTENIMIENTO"  || user.category == "SAC" || user.category == "Sec COMPUTO" || user.category == "Dirección"
      can :read, :show_maintenance_tickets
    elsif user.category == "Admin COMUNICACION"  || user.category == "SAC" || user.category == "Sec COMPUTO" || user.category == "Dirección"
      can :read, :show_communication_tickets
    elsif user.category == "Admin COMPUTO" || user.category == "Admin ELECTRONICA" || user.category == "Admin TALLER"  || user.category == "Admin COMUNICACION" || user.category == "Admin MANTENIMIENTO" || user.category == "Admin SERVICIOS" || user.category == "SAC" || user.category == "Sec COMPUTO"
      can :manage, Category
    else
      can :read, :all
      #can :create, Score
    end
  end
end
