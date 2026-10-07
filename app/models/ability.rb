class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    # Administrador general
    if user.category == "Chuck Norris"
      can :manage, User
      can :manage, Technician
      can :manage, Category
      can :manage, Assignation          
      can :manage, Assignment          
      can :manage, Score
      can :manage, Ticket
      can :autocomplete_user_name, User
      return
    end

    # Roles con acceso transversal a las vistas solicitadas
    global_roles = ["SAC", "Sec COMPUTO", "Dirección"]
    is_global = global_roles.include?(user.category)

    if is_global
      can :autocomplete_user_name, User
    end

    # Permisos Tickets Personales
    if ["Admin COMPUTO", "Personal COMPUTO", "Sec COMPUTO"].include?(user.category)
      can :read, :show_personal_tickets
    end

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
    #if user.category == "Admin TALLER" || is_global
      #can :read, :show_workshop_tickets
    #end
    # Permisos de TALLER
    if user.category == "Admin TALLER"
      can :read, :show_workshop_tickets # Permiso para tickets_path
    end

    if is_global
      can :read, :show_workshop_tickets_with_search # Permiso para show_workshop_tickets_with_search_path
    end

    # Permisos de MANTENIMIENTO
    if user.category == "Admin MANTENIMIENTO" || is_global
      can :read, :show_maintenance_tickets
      can :read, :show_maintenance_tickets_with_advanced_search
      can :autocomplete_user_name, User
    end

    # Permisos de COMUNICACIÓN
    if user.category == "Admin COMUNICACION" || is_global
      can :read, :show_communication_tickets
      can :read, :show_communication_tickets_with_advanced_search
    end

    # =========================================================================
    # REGLAS Y ACCIONES SOBRE EL MODELO TICKET (Administrar, Tomar, Cerrar)
    # =========================================================================

    # 1. Permisos para Editar / Administrar Solicitud
    admin_departments = case user.category
                        when "Sec COMPUTO", "Admin COMPUTO" then ['computo']
                        #when "Admin COMUNICACION"     	    then ['comunicacion']
                        when "SAC", "Admin ELECTRONICA"     then ['electronica']
                        when "Admin MANTENIMIENTO"          then ['mantenimiento']
                        else []
                        end

    can :edit, Ticket, department: admin_departments if admin_departments.any?

    # 2. Permisos para Tomar y Cerrar Ticket
    action_departments = case user.category
                         when "Sec COMPUTO", "Admin COMPUTO" then ['computo']
                         when "Admin ELECTRONICA"            then ['electronica']
                         when "Admin COMUNICACION"           then ['comunicacion']
                         else []
                         end

    if action_departments.any?
      # Permiso para Tomar Ticket
      can :take, Ticket, department: action_departments, status: "NO_ATENDIDO"

      # Permiso para Cerrar Ticket
      can :close, Ticket do |ticket|
        action_departments.include?(ticket.department) &&
          %w[EN_PROCESO EN_REVISION EN_ESPERA].include?(ticket.status) &&
          ticket.technicians.any?
      end
    end

    # =========================================================================
    # REGLAS Y ACCIONES SOBRE EL MODELO TICKET (Administrar, Tomar, Cerrar)
    # =========================================================================

    # 1. Permisos para Editar / Administrar Solicitud
    admin_departments = case user.category
                        when "Sec COMPUTO", "Admin COMPUTO", "Personal COMPUTO"
                          ['computo', 'COMPUTO']
                        when "Admin TALLER"
                          ['taller', 'TALLER']
                        when "Admin ELECTRONICA", "Personal ELECTRONICA"
                          ['electronica', 'ELECTRONICA']
                        when "Admin COMUNICACION", "Personal COMUNICACION"
                          ['comunicacion', 'COMUNICACION']
                        when "Admin MANTENIMIENTO", "Personal MANTENIMIENTO"
                          ['mantenimiento', 'MANTENIMIENTO']
                        when "SAC"
                          ['electronica', 'ELECTRONICA', 'comunicacion', 'COMUNICACION']
                        else
                          []
                        end

    if admin_departments.any?
      can :edit, Ticket, department: admin_departments
    end

    # Permiso especial para el usuario ID 182
    if user.id == 182
      can :edit, Ticket
    end

  end
end
