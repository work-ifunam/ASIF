module ApplicationHelper
  def current_department_icon
    # 1. Intentar obtener el departamento por parámetro o modelo @ticket
    dept = params[:department]
    dept ||= @ticket.department if @ticket.respond_to?(:department) && @ticket.department.present?

    # 2. Si no viene explícito, inferirlo del nombre de la acción actual
    if dept.blank?
      case action_name
      when /comunicacion|communication/ then dept = 'comunicacion'
      when /electronica|electronic/    then dept = 'electronica'
      when /mantenimiento|maintenance/ then dept = 'mantenimiento'
      when /taller|workshop/           then dept = 'taller'
      end
    end

    # 3. Mapear al archivo de imagen correspondiente (por defecto icono_computo.png)
    case dept.to_s.downcase
    when 'comunicacion'  then 'icono_comunicacion.png'
    when 'electronica'   then 'icono_electronica.png'
    when 'mantenimiento' then 'icono_mantenimiento.png'
    when 'taller'        then 'icono_taller.png'
    else                      'icono_computo.png'
    end
  end
end
