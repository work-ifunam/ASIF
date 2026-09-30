class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    # Administrador general
    if user.category == "Chuck Norris"
    #if user.category == "Chuck Norris" || user.id == 169
      can :manage, User
      can :manage, Technician
      can :manage, Category
      can :manage, Assignation          
      can :manage, Assignment          
      can :manage, Score
      can :manage, Ticket
      return
    end

    # Roles con acceso transversal a las vistas solicitadas
    global_roles = ["SAC", "Sec COMPUTO", "Dirección"]
    is_global = global_roles.include?(user.category)

    # Permisos de CÓMPUTO
    if user.category == "Admin COMPUTO" || is_global
      can :read, :show_computer_tickets
      can :read, :show_computer_tickets_with_advanced_search
    end

    # Permisos de ELECTRÓNICA
    if user.category == "Admin ELECTRONICA" || is_global
      can :read, :show_computer_tickets_with_advanced_search
      can :read, :show_electronic_tickets_with_advanced_search
    end

    # Permisos de TALLER / MANTENIMIENTO
    if user.category == "Admin TALLER" || is_global
      can :read, :show_workshop_tickets
      can :read, :show_maintenance_tickets_with_advanced_search
    end

    if user.category == "Admin MANTENIMIENTO" || is_global
      can :read, :show_maintenance_tickets
    end

    # Permisos de COMUNICACIÓN
    if user.category == "Admin COMUNICACION" || is_global
      can :read, :show_communication_tickets
    end
  end
end
