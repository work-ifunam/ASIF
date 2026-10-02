class ReportsController < ApplicationController
  before_filter :require_user, :current_year

  DEPARTMENT_NAMES = {
    "computo"      => "Cómputo",
    "taller"       => "Taller",
    "electronica"  => "Electrónica",
    "comunicacion" => "Comunicación",
    "mantenimiento"=> "Mantenimiento",
    "servicio"     => "Servicio"
  }.freeze

  def index
    @my_workshop     = tickets_for_user_department("taller")
    @my_electronic   = tickets_for_user_department("electronica")
    @my_computer     = tickets_for_user_department("computo")
    @my_communication= tickets_for_user_department("comunicacion")
    @my_maintenance  = tickets_for_user_department("mantenimiento")
    @my_service      = tickets_for_user_department("servicio")
  end

  # Acción genérica reutilizable
  def department_reports
    @department_slug = params[:department] || extract_department_from_action
    @department_name = DEPARTMENT_NAMES[@department_slug] || @department_slug.titleize

    tickets_list = tickets_for_user_department(@department_slug)
    @tickets = Kaminari.paginate_array(tickets_list).page(params[:page])

    render "department_reports"
  end

  # Mantener compatibilidad con los métodos anteriores
  alias_method :my_workshop_reports,     :department_reports
  alias_method :my_electronic_reports,   :department_reports
  alias_method :my_computer_reports,     :department_reports
  alias_method :my_communication_reports,:department_reports
  alias_method :my_maintenance_reports,  :department_reports
  alias_method :my_service_reports,      :department_reports

  def approve_ticket
    @ticket = Ticket.find(params[:id])
    @ticket.client_status = "APROBADO"
    @ticket.status = "ENTREGADO"
    @ticket.save
    redirect_to :back
  end

  def not_approve_ticket
    @ticket = Ticket.find(params[:id])
    @ticket.client_status = "NO_APROBADO"
    @ticket.status = "EN_REVISION"
    @ticket.save
    redirect_to :back
  end

  def generate_report
    @tickets = Ticket.all
  end

  private

  def tickets_for_user_department(dept)
    Ticket.find(:all, conditions: ['user_id = ? AND department = ?', current_user.id, dept], order: "created_at DESC")
  end

  def extract_department_from_action
    action_name.gsub(/^my_|_reports$/, '')
  end
end
