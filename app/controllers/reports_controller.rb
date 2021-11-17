class ReportsController < ApplicationController

  before_filter :require_user

  def index
    @my_workshop = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "taller"], :order => "created_at DESC")
    @my_electronic = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "electronica"], :order => "created_at DESC")
    @my_computer = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "computo"], :order => "created_at DESC")
    @my_communication = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "comunicacion"], :order => "created_at DESC")
    @my_maintenance = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "mantenimiento"], :order => "created_at DESC")
  end

  def my_workshop_reports
    @my_workshop = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "taller"], :order => "created_at DESC")
    @workshop_tickets = Kaminari.paginate_array(@my_workshop).page(params[:page])
  end

  def my_electronic_reports
    @my_electronic = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "electronica"], :order => "created_at DESC")
    @electronic_tickets = Kaminari.paginate_array(@my_electronic).page(params[:page])
  end

  def my_computer_reports
    @my_computer = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "computo"], :order => "created_at DESC")
    @computer_tickets = Kaminari.paginate_array(@my_computer).page(params[:page])
  end

  def my_communication_reports
    @my_communication = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "comunicacion"], :order => "created_at DESC")
    @communication_tickets = Kaminari.paginate_array(@my_communication).page(params[:page])
  end
  
  def my_maintenance_reports
    @my_maintenance = Ticket.find(:all, :conditions => ['user_id = ? AND department = ?', current_user.id, "mantenimiento"], :order => "created_at DESC")
    @maintenance_tickets = Kaminari.paginate_array(@my_maintenance).page(params[:page])
  end

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

end
