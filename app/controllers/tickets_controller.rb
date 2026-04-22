class TicketsController < ApplicationController
  before_filter :require_user, :current_year, :last_year 

def index
    tickets = Ticket.user(current_user.category)
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
    if current_user.category == "Admin COMPUTO" || current_user.category == "Chuck Norris" || current_user.category == "Sec COMPUTO"
      #if current_user.email == 'daniel@fisica.unam.mx'
        @search = TicketSearch.new(params[:search])
        @ticket_type = 'computo'
        @tickets = @search.scope(@ticket_type)
        if params[:date_from] && params[:date_to]  
          @download = @search.full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to])
        else
          @download = @tickets
        end
        #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
        @notattended = @search.scope_status('NO_ATENDIDO', @ticket_type)
        @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
        @revision = @search.scope_status('EN_REVISION', @ticket_type)
        @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
        @finished = @search.scope_status('ENTREGADO', @ticket_type)
        @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
        @inprocess = @search.scope_status('EN_PROCESO', @ticket_type)
        @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
        @waiting = @search.scope_status('EN_ESPERA', @ticket_type)
        @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
        @canceled = @search.scope_status('CANCELADO', @ticket_type)
        @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
      #else
      #@computer_tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"])
      
      #@computer_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"computo", @current_year])
      #@computer_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","computo", @current_year])
      #@computer_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","computo", @current_year])
      
      #@computer_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","computo", @current_year])
      #@computer_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","computo", @current_year])
      #@computer_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","computo", @current_year])
      #@computer_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","computo", @current_year])
      #@computer_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","computo", @current_year])
      #end
    elsif current_user.category == "Admin ELECTRONICA" || current_user.category == "Personal ELECTRONICA" || current_user.category == "SAC" || current_user.category == "Sec COMPUTO"
        @search = TicketSearch.new(params[:search])
        @ticket_type = 'electronica'
        @tickets = @search.scope(@ticket_type)
        if params[:date_from] && params[:date_to]  
          @download = @search.full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to])
        else
          @download = @tickets
        end
        #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
        @notattended = @search.scope_status('NO_ATENDIDO', @ticket_type)
        @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
        @revision = @search.scope_status('EN_REVISION', @ticket_type)
        @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
        @finished = @search.scope_status('ENTREGADO', @ticket_type)
        @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
        @inprocess = @search.scope_status('EN_PROCESO', @ticket_type)
        @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
        @waiting = @search.scope_status('EN_ESPERA', @ticket_type)
        @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
        @canceled = @search.scope_status('CANCELADO', @ticket_type)
        @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
      #@ticket_type = 'electronica'
      #@electronic_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) >= ?',"electronica", @last_year])
      #@electronic_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_REVISION","electronica", @last_year])
      #@electronic_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "ENTREGADO","electronica", @last_year])
      #@electronic_inprocess = Ticket.find(:all, :conditions => ['(status = ? OR status = ?) AND department = ? AND extract(year  from created_at) >= ?', "EN_PROCESO", "EN_REVISION", "electronica", @last_year])
    #@electronic_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "NO_ATENDIDO","electronica", @last_year])
    #@electronic_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_ESPERA","electronica", @last_year])
    #@electronic_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "CANCELADO","electronica", @last_year])
    elsif current_user.category == "Admin TALLER" || current_user.category == "Personal TALLER" || current_user.category == "Sec COMPUTO"
      @workshop_tickets = Ticket.find(:all, :conditions => ['department = ?', "taller"])
      @workshop_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", "taller"])
      @workshop_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", "taller"])
      @workshop_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", "taller"])
      @workshop_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", "taller"])
      @workshop_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", "taller"])
      @workshop_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", "taller"])
      #@workshop_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","taller", @current_year])
      #@workshop_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","taller", @current_year])
      #@workshop_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","taller", @current_year])
      #@workshop_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","taller", @current_year])
      #@workshop_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","taller", @current_year])
      #@workshop_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","taller", @current_year])
    elsif current_user.category == "Admin MANTENIMIENTO" || current_user.category == "Personal MANTENIMIENTO" || current_user.category == "Sec COMPUTO"
      @maintenance_tickets = Ticket.find(:all, :conditions => ['department = ? AND created_at >= ?',"mantenimiento", 1.year.ago], :order => "created_at DESC")
      @maintenance_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO","mantenimiento", 1.year.ago])
      @maintenance_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION","mantenimiento", 1.year.ago])
      @maintenance_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO","mantenimiento", 1.year.ago])
      @maintenance_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO","mantenimiento", 1.year.ago])
      @maintenance_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA","mantenimiento", 1.year.ago])
      @maintenance_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO","mantenimiento", 1.year.ago])
    elsif current_user.category == "Admin SERVICIO" || current_user.category == "Personal SERVICIO" || current_user.category == "Sec COMPUTO"
      @servicio_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"servicio", @current_year])
      @servicio_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","servicio", @current_year])
      @servicio_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","servicio", @current_year])
      @servicio_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","servicio", @current_year])
      @servicio_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","servicio", @current_year])
      @servicio_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","servicio", @current_year])
      @servicio_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","servicio", @current_year])
    elsif current_user.category == "Admin COMUNICACION" || current_user.category == "Personal COMUNICACION" || current_user.category == "SAC" || current_user.category == "Sec COMPUTO"
      @communication_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) >= ?',"comunicacion", @last_year])
      @communication_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_REVISION","comunicacion", @last_year])
      @communication_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "ENTREGADO","comunicacion", @last_year])
      @communication_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_PROCESO","comunicacion", @last_year])
      @communication_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "NO_ATENDIDO","comunicacion", @last_year])
      @communication_waiting= Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_ESPERA","comunicacion", @last_year])
      @communication_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "CANCELADO","comunicacion", @last_year])
    end  

    respond_to do |format|
      format.html 
      format.json { render json: @tickets }
      format.xls { 
        render xls: @download
      }
    end
  end
#Personal Tickets
  def show_personal_tickets
    @ticket_type = 'computo'
       tickets =  Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech ', department: 'computo', tech: current_user.tech).order('tickets.created_at DESC')
       @computer_tickets_tech = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech', department: 'computo', tech: current_user.tech).where('extract(year from tickets.created_at) = ?', @current_year).order('tickets.created_at DESC')
       @revision = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'EN_REVISION').where('extract(year from tickets.created_at) = ?', @current_year).order('tickets.created_at DESC')
       @notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","computo", @current_year], :order => "created_at DESC")
       @finished = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'ENTREGADO').where('extract(year from tickets.created_at) = ?', @current_year).order('tickets.created_at DESC')
       @inprocess = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'EN_PROCESO').where('extract(year from tickets.created_at) = ?', @current_year).order('tickets.created_at DESC')
       @waiting = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'EN_ESPERA').where('extract(year from tickets.created_at) = ?', @current_year).order('tickets.created_at DESC')
       @canceled = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'CANCELADOS').where('extract(year from tickets.created_at) = ?', @current_year).order('tickets.created_at DESC')
       @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
       @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
       @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
       @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
       @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
       @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
       @tickets_notattended_count = @notattended.count 
       @download = @computer_tickets_tech
    #tickets =  Ticket.joins(:technicians).where(:all, :conditions => ['department = ? AND assignments.technician_id =?', 'computo', current_user.tech], :order => "created_at DESC")
    #tickets =  Ticket.joins(:technicians).where('department = "computo" and current_user.tech = assignments.technician_id', :order => "created_at DESC")
    #tickets = Ticket.find(:all, :conditions => ['department = ? AND technicians = ?',"computo", current_user.tech])
    #tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
    #render :layout => 'show_computer_tickets'
    respond_to do |format|
      format.html 
      format.json { render json: @tickets }
      format.xls { 
        render xls: @download
      }
    end
  end
#Show Department Tickets
  def show_computer_tickets

      @search = TicketSearch.new(params[:search])
      @computer_tickets = @search.scope('computo')
      #@computer_tickets = Ticket.find(:all, :conditions => ['department = ? AND created_at >= ?',"computo", 1.year.ago], :order => "created_at DESC")

     #@computer_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"computo", @current_year], :order => "created_at DESC")
     #tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"], :order => "created_at DESC")
     @tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
     #@computer_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO","computo", 1.year.ago], :order => "created_at DESC")
     @computer_notattended = @search.scope_status('NO_ATENDIDO', 'computo')
     @computer_revision = @search.scope_status('EN_REVISION', 'computo')
     @computer_finished = @search.scope_status('ENTREGADO', 'computo')
     @computer_inprocess = @search.scope_status('EN_PROCESO', 'computo')
     @computer_waiting = @search.scope_status('EN_ESPERA', 'computo')
     @computer_canceled = @search.scope_status('CANCELADO', 'computo')

     #@computer_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION","computo", 1.year.ago], :order => "created_at DESC")
     #@computer_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO","computo", 1.year.ago], :order => "created_at DESC")
     #@computer_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO","computo", 1.year.ago], :order => "created_at DESC")
     #@computer_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA", "computo", 1.year.ago], :order => "created_at DESC")
     #@computer_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO","computo", 1.year.ago], :order => "created_at DESC")
    #render :layout => 'show_computer_tickets'
  end  

  def show_computer_tickets_with_search
    @search = TicketSearch.new(params[:search])
    @ticket_type = 'computo'
    @computer_tickets = @search.scope('computo')
    if params[:date_from] && params[:date_to]  
      @download = @search.full_scope(params[:cat], 'computo', params[:date_from], params[:date_to])
    else
      @download = @computer_tickets
    end
    #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
    @computer_notattended = @search.scope_status('NO_ATENDIDO', 'computo')
    @tickets_notattended = Kaminari.paginate_array(@computer_notattended).page(params[:page])
    @computer_revision = @search.scope_status('EN_REVISION', 'computo')
    @tickets_revision = Kaminari.paginate_array(@computer_revision).page(params[:page])
    @computer_finished = @search.scope_status('ENTREGADO', 'computo')
    @tickets_finished = Kaminari.paginate_array(@computer_finished).page(params[:page])
    @computer_inprocess = @search.scope_status('EN_PROCESO', 'computo')
    @tickets_inprocess = Kaminari.paginate_array(@computer_inprocess).page(params[:page])
    @computer_waiting = @search.scope_status('EN_ESPERA', 'computo')
    @tickets_waiting = Kaminari.paginate_array(@computer_waiting).page(params[:page])
    @computer_canceled = @search.scope_status('CANCELADO', 'computo')
    @tickets_canceled = Kaminari.paginate_array(@computer_canceled).page(params[:page])
    #render :layout => 'boostrap_application'
    respond_to do |format|
      format.html 
      format.json { render json: @computer_tickets }
      format.xls { 
        render xls: @download
      }
    end
  #render :layout => 'show_computer_tickets'
end

def show_communication_tickets_with_search
  @search = TicketSearch.new(params[:search])
  @ticket_type = 'comunicacion'
  @tickets = @search.scope(@ticket_type)
  if params[:date_from] && params[:date_to]  
    @download = @search.full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to])
  else
    @download = @tickets
  end
  #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
  @notattended = @search.scope_status('NO_ATENDIDO', @ticket_type)
  @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
  @revision = @search.scope_status('EN_REVISION', @ticket_type)
  @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
  @finished = @search.scope_status('ENTREGADO', @ticket_type)
  @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
  @inprocess = @search.scope_status('EN_PROCESO', @ticket_type)
  @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
  @waiting = @search.scope_status('EN_ESPERA', @ticket_type)
  @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
  @canceled = @search.scope_status('CANCELADO', @ticket_type)
  @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
  #render :layout => 'boostrap_application'
  respond_to do |format|
    format.html 
    format.json { render json: @tickets }
    format.xls { render xls: @download}
  end
#render :layout => 'show_computer_tickets'
end  

def show_workshop_tickets_with_search
  @search = TicketSearch.new(params[:search])
  @ticket_type = 'taller'
  @tickets = @search.scope(@ticket_type)
  if params[:date_from] && params[:date_to]  
    @download = @search.full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to])
  else
    @download = @tickets
  end
  #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
  @notattended = @search.scope_status('NO_ATENDIDO', @ticket_type)
  @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
  @revision = @search.scope_status('EN_REVISION', @ticket_type)
  @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
  @finished = @search.scope_status('ENTREGADO', @ticket_type)
  @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
  @inprocess = @search.scope_status('EN_PROCESO', @ticket_type)
  @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
  @waiting = @search.scope_status('EN_ESPERA', @ticket_type)
  @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
  @canceled = @search.scope_status('CANCELADO', @ticket_type)
  @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
  #render :layout => 'boostrap_application'
  respond_to do |format|
    format.html 
    format.json { render json: @tickets }
    format.xls { render xls: @download}
  end
#render :layout => 'show_computer_tickets'
end  

def show_electronic_tickets_with_search
  @search = TicketSearch.new(params[:search])
  @ticket_type = 'electronica'
  @tickets = @search.scope(@ticket_type)
  if params[:date_from] && params[:date_to]  
    @download = @search.full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to])
  else
    @download = @tickets
  end
  #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
  @notattended = @search.scope_status('NO_ATENDIDO', @ticket_type)
  @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
  @revision = @search.scope_status('EN_REVISION', @ticket_type)
  @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
  @finished = @search.scope_status('ENTREGADO', @ticket_type)
  @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
  @inprocess = @search.scope_status('EN_PROCESO', @ticket_type)
  @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
  @waiting = @search.scope_status('EN_ESPERA', @ticket_type)
  @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
  @canceled = @search.scope_status('CANCELADO', @ticket_type)
  @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
  #render :layout => 'boostrap_application'
  respond_to do |format|
    format.html 
    format.json { render json: @tickets }
    format.xls { render xls: @download}
  end
#render :layout => 'show_computer_tickets'
end  

      def my_chart_data
	@notattended = notattended
	logger.debug "MY CHART NOT ATTENDED: #{@notattended}"
        data_array = [["NO ATENDIDO", "10"],["EN REVISION", "90"]]
	data = data_array.to_json
	#data = @search.advanced_scope(@ticket_type) { |item| [item.label, item.value] }
        render json: data
      end

def show_electronic_tickets_with_advanced_search
  logger.debug "--------------------------------------"
  logger.debug "SHOW ELECTRONIC TICKETS WITH ADVANCED SEARCH"
  @search = TicketSearch.new(params[:search])
  @ticket_type = 'electronica'
  #Filtro de busqueda

  if @search.folio
  	logger.debug "--------------------------------------"
  	logger.debug "SHOW ELECTRONIC TICKETS WITH ADVANCED SEARCH------ONLY FOLIO"
  	logger.debug "--------------------------------------"
  	@tickets = @search.scope_with_folio(@ticket_type, @search.folio)
  else
  	logger.debug "--------------------------------------"
  	logger.debug "SHOW ELECTRONIC TICKETS WITH ADVANCED SEARCH------IGNORING FOLIO"
  	logger.debug "--------------------------------------"
  	@tickets = @search.advanced_scope(@ticket_type)
  end
  if params[:date_from] && params[:date_to]
  	#Generacion de archivo xls
  	logger.debug "--------------------------------------"
  	logger.debug "ENTER TO DOWNLOAD OPTION"
    	@download = @search.tech_full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to], params[:tech_id])
  else
    @download = @tickets
  end
  #Filtro por status
  #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
  @notattended = @search.advanced_scope_with_status('NO_ATENDIDO', @ticket_type)
  @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
  @revision = @search.advanced_scope_with_status('EN_REVISION', @ticket_type)
  @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
  @finished = @search.advanced_scope_with_status('ENTREGADO', @ticket_type)
  @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
  @inprocess = @search.advanced_scope_with_status('EN_PROCESO', @ticket_type)
  @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
  @waiting = @search.advanced_scope_with_status('EN_ESPERA', @ticket_type)
  @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
  @canceled = @search.advanced_scope_with_status('CANCELADO', @ticket_type)
  @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
  #render :layout => 'boostrap_application'
  respond_to do |format|
    format.html 
    #format.html {render :layout => 'boostrap_application2'}
    format.json { render json: @tickets }
    format.xls { render xls: @download}
  end
#render :layout => 'show_computer_tickets'
end  

def show_maintenance_tickets_with_search
  @search = TicketSearch.new(params[:search])
  @ticket_type = 'mantenimiento'
  @tickets = @search.scope(@ticket_type)
  if params[:date_from] && params[:date_to]  
    @download = @search.full_scope(params[:cat], @ticket_type, params[:date_from], params[:date_to])
  else
    @download = @tickets
  end
  #@tickets = Kaminari.paginate_array(@computer_tickets).page(params[:page])
  @notattended = @search.scope_status('NO_ATENDIDO', @ticket_type)
  @tickets_notattended = Kaminari.paginate_array(@notattended).page(params[:page])
  @revision = @search.scope_status('EN_REVISION', @ticket_type)
  @tickets_revision = Kaminari.paginate_array(@revision).page(params[:page])
  @finished = @search.scope_status('ENTREGADO', @ticket_type)
  @tickets_finished = Kaminari.paginate_array(@finished).page(params[:page])
  @inprocess = @search.scope_status('EN_PROCESO', @ticket_type)
  @tickets_inprocess = Kaminari.paginate_array(@inprocess).page(params[:page])
  @waiting = @search.scope_status('EN_ESPERA', @ticket_type)
  @tickets_waiting = Kaminari.paginate_array(@waiting).page(params[:page])
  @canceled = @search.scope_status('CANCELADO', @ticket_type)
  @tickets_canceled = Kaminari.paginate_array(@canceled).page(params[:page])
  #render :layout => 'boostrap_application'
  respond_to do |format|
    format.html 
    format.json { render json: @tickets }
    format.xls { render xls: @download}
  end
#render :layout => 'show_computer_tickets'
end  

  def show_service_tickets
    tickets = Ticket.find(:all, :conditions => ['department = ?', "service"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
     @service_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","servicio", @current_year])
     @service_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","servicio", @current_year])
     @service_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","servicio", @current_year])
     @service_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","servicio", @current_year])
     @service_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","servicio", @current_year])
     @service_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","servicio", @current_year])
    render :layout => 'show_service_tickets'
  end  
  
  def show_maintenance_tickets
    #tickets = Ticket.find(:all, :conditions => ['department = ?', "mantenimiento"], :order => "created_at DESC")
    #@tickets = Kaminari.paginate_array(tickets).page(params[:page])
     #@maintenance_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","mantenimiento", @current_year])
     #@maintenance_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","mantenimiento", @current_year])
     #@maintenance_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","mantenimiento", @current_year])
     #@maintenance_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","mantenimiento", @current_year])
     #@maintenance_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","mantenimiento", @current_year])
     #@maintenance_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","mantenimiento", @current_year])
    #render :layout => 'show_maintenance_tickets'
    @maintenance_tickets = Ticket.find(:all, :conditions => ['department = ? AND created_at >= ?',"mantenimiento", 1.year.ago], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(@maintenance_tickets).page(params[:page])
    @maintenance_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO","mantenimiento", 1.year.ago], :order => "created_at DESC")
    @maintenance_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION","mantenimiento", 1.year.ago], :order => "created_at DESC")
    @maintenance_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO","mantenimiento", 1.year.ago], :order => "created_at DESC")
    @maintenance_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO","mantenimiento", 1.year.ago], :order => "created_at DESC")
    @maintenance_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA", "mantenimiento", 1.year.ago], :order => "created_at DESC")
    @maintenance_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO","mantenimiento", 1.year.ago], :order => "created_at DESC")
  end  

  def show_communication_tickets
    #tickets = Ticket.find(:all, :conditions => ['department = ?', "comunicacion"], :order => "created_at DESC")
    #@tickets = Kaminari.paginate_array(tickets).page(params[:page])
     #@communication_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"comunicacion", @current_year])
     #@communication_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","comunicacion", @current_year])
     #@communication_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","comunicacion", @current_year])
     #@communication_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","comunicacion", @current_year])
    # @communication_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","comunicacion", @current_year])
     #@communication_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","comunicacion", @current_year])
     #@communication_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","comunicacion", @current_year])
    #render :layout => 'show_communication_tickets'
     @communication_tickets = Ticket.find(:all, :conditions => ['department = ? AND created_at >= ?',"comunicacion", 1.year.ago], :order => "created_at DESC")
     @tickets = Kaminari.paginate_array(@communication_tickets).page(params[:page])
     @communication_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO","comunicacion", 1.year.ago], :order => "created_at DESC")
     @communication_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION","comunicacion", 1.year.ago], :order => "created_at DESC")
     @communication_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO","comunicacion", 1.year.ago], :order => "created_at DESC")
     @communication_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO","comunicacion", 1.year.ago], :order => "created_at DESC")
     @communication_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA", "comunicacion", 1.year.ago], :order => "created_at DESC")
     @communication_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO","comunicacion", 1.year.ago], :order => "created_at DESC")
  end  

  def show_electronic_tickets
    #tickets = Ticket.find(:all, :conditions => ['department = ?', "electronica"], :order => "created_at DESC")
    #@tickets = Kaminari.paginate_array(tickets).page(params[:page])
    #@electronic_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_REVISION","electronica", @last_year])
    #@electronic_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", "electronica"])
    #@electronic_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "ENTREGADO","electronica", @last_year ])
    #@electronic_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", "electronica"])
    #@electronic_inprocess = Ticket.find(:all, :conditions => ['(status = ? OR status = ?) AND department = ? AND extract(year  from created_at) >= ?', "EN_PROCESO", "EN_REVISION", "electronica", @last_year])
    #@electronic_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", "electronica"])
    #@electronic_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "NO_ATENDIDO","electronica", @last_year])
    #@electronic_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", "electronica"])
    #electronic_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "EN_ESPERA","electronica", @last_year])
    #@electronic_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", "electronica"])
    #@electronic_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) >= ?', "CANCELADO","electronica", @last_year])
    #@electronic_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", "electronica"])
    #render :layout => 'show_electronic_tickets'
    
    @electronic_tickets = Ticket.find(:all, :conditions => ['department = ? AND created_at >= ?',"electronica", 1.year.ago], :order => "created_at DESC")
    #@computer_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"computo", @current_year], :order => "created_at DESC")
    #tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(@electronic_tickets).page(params[:page])
    @electronic_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO","electronica", 1.year.ago], :order => "created_at DESC")
    @electronic_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION","electronica", 1.year.ago], :order => "created_at DESC")
    @electronic_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO","electronica", 1.year.ago], :order => "created_at DESC")
    @electronic_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO","electronica", 1.year.ago], :order => "created_at DESC")
    @electronic_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA", "electronica", 1.year.ago], :order => "created_at DESC")
    @electronic_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO","electronica", 1.year.ago], :order => "created_at DESC")
   #render :layout => 'show_computer_tickets'
  end

  def show_workshop_tickets
    tickets = Ticket.find(:all, :conditions => ['department = ?', "taller"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
    @workshop_tickets = Ticket.find(:all, :conditions => ['department = ?', "taller"])
    #@workshop_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","taller", @current_year])
    #@workshop_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","taller", @current_year])
    #@workshop_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","taller", @current_year])
    #@workshop_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","taller", @current_year])
    #@workshop_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","taller", @current_year])
    #@workshop_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","taller", @current_year])
    #@workshop_tickets = Ticket.find(:all, :conditions => ['department = ?', "taller"])
    
    #@workshop_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", "taller"])
    #@workshop_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", "taller"])
    #@workshop_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", "taller"])
    #@workshop_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", "taller"])
    #@workshop_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", "taller"])
    #@workshop_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", "taller"])
    #render :layout => 'show_workshop_tickets'

    @workshop_tickets = Ticket.find(:all, :conditions => ['department = ? AND created_at >= ?',"taller", 1.year.ago], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(@workshop_tickets).page(params[:page])
    @workshop_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO","taller", 1.year.ago], :order => "created_at DESC")
    @workshop_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION","taller", 1.year.ago], :order => "created_at DESC")
    @workshop_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO","taller", 1.year.ago], :order => "created_at DESC")
    @workshop_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO","taller", 1.year.ago], :order => "created_at DESC")
    @workshop_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA", "taller", 1.year.ago], :order => "created_at DESC")
    @workshop_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO","taller", 1.year.ago], :order => "created_at DESC")
  end   

#End Department Tickets
#Show Status Tickets

  def show_inprocess_tickets
    if params[:department] == "electronica" && current_user.category == "SAC"
      @tickets_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) >= ?', "EN_PROCESO", params[:department], @last_year], :order => "created_at DESC")
    elsif params[:tech] 
        @tickets_inprocess = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: params[:department], tech: current_user.tech, status: 'EN_PROCESO').where('extract(year from tickets.created_at) = ?', @current_year)
      elsif (params[:department] == "computo" && (current_user.category == "Sec COMPUTO" || current_user.category == "Admin COMPUTO")) || current_user.category == "Chuck Norris"
        @tickets_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", params[:department]], :order => "created_at DESC")
    else
    	@tickets_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_PROCESO", params[:department], 1.year.ago], :order => "created_at DESC")
    end
    @tickets = Kaminari.paginate_array(@tickets_inprocess).page(params[:page])
    #if params[:department] == "computo"
      #render :layout => 'show_computer_tickets'
    #elsif params[:department] == "taller"
      #render :layout => 'show_workshop_tickets'
    #elsif params[:department] == "electronica"
      #render :layout => 'show_electronic_tickets'
    #elsif params[:department] == "mantenimiento"
      #render :layout => 'show_maintenance_tickets'
    #elsif params[:department] == "comunicacion"
      #render :layout => 'show_communication_tickets'
    #end
  end

  def show_unattended_tickets
    if (params[:department] == "electronica" && (current_user.category == "SAC" || current_user.category == "Admin ELECTRONICA" )) || (params[:department] == "comunicacion" && current_user.category == "Admin COMUNICACION")
      @ticket_unattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) >= ?', "NO_ATENDIDO", params[:department], @last_year], :order => "created_at DESC")
    elsif params[:tech]
        @ticket_unattended = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: params[:department], tech: current_user.tech, status: 'NO_ATENDIDO').where('extract(year from tickets.created_at) = ?', @current_year)
      elsif (params[:department] == "computo" && (current_user.category == "Sec COMPUTO" || current_user.category == "Admin COMPUTO")) || current_user.category == "Chuck Norris"
        @ticket_unattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", params[:department]], :order => "created_at DESC")
    else
    	@ticket_unattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "NO_ATENDIDO", params[:department], 1.year.ago], :order => "created_at DESC")
    end
    @tickets = Kaminari.paginate_array(@ticket_unattended).page(params[:page])
    #if params[:department] == "computo"
      #render :layout => 'show_computer_tickets'
    #elsif params[:department] == "taller"
      #render :layout => 'show_workshop_tickets'
    #elsif params[:department] == "electronica"
      #render :layout => 'show_electronic_tickets'
    #elsif params[:department] == "mantenimiento"
      #render :layout => 'show_maintenance_tickets'
    #elsif params[:department] == "comunicacion"
      #render :layout => 'show_communication_tickets'
    #end
  end

  def show_attended_tickets
    #if params[:department] == "electronica"
    #	@tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", params[:department]], :order => "created_at DESC")
    #else
	#
    #	if params[:tech] 
     #   	@tickets = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'ENTREGADO').where('extract(year from tickets.created_at) = ?', @current_year)
    #	else
    #	@tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) = ?', "ENTREGADO", params[:department], @current_year], :order => "created_at DESC")
    #	end
	#
    #end
    #@tickets_count = @tickets
    #@tickets = Kaminari.paginate_array(@tickets).page(params[:page])
    if (params[:department] == "electronica" && (current_user.category == "SAC" || current_user.category == "Admin ELECTRONICA" )) || (params[:department] == "comunicacion" && current_user.category == "Admin COMUNICACION")
      @tickets_attended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) >= ?', "ENTREGADO", params[:department], @last_year], :order => "created_at DESC")
    elsif params[:tech] 
        @tickets_attended = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: params[:department], tech: current_user.tech, status: 'ENTREGADO').where('extract(year from tickets.created_at) = ?', @current_year)
      elsif (params[:department] == "computo" && (current_user.category == "Sec COMPUTO" || current_user.category == "Admin COMPUTO")) || current_user.category == "Chuck Norris"
        @tickets_attended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", params[:department]], :order => "created_at DESC")
    else
    	@tickets_attended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "ENTREGADO", params[:department], 1.year.ago], :order => "created_at DESC")
    end
    @tickets = Kaminari.paginate_array(@tickets_attended).page(params[:page])
    #if params[:department] == "computo"
      #render :layout => 'show_computer_tickets'
    #elsif params[:department] == "taller"
      #render :layout => 'show_workshop_tickets'
    #elsif params[:department] == "electronica"
      #render :layout => 'show_electronic_tickets'
    #elsif params[:department] == "mantenimiento"
      #render :layout => 'show_maintenance_tickets'
    #elsif params[:department] == "comunicacion"
      #render :layout => 'show_communication_tickets'
    #end
  end

  def show_froze_tickets
    if (params[:department] == "electronica" && (current_user.category == "SAC" || current_user.category == "Admin ELECTRONICA" )) || (params[:department] == "comunicacion" && current_user.category == "Admin COMUNICACION")
      @ticket_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) >= ?', "EN_ESPERA", params[:department], @last_year], :order => "created_at DESC")
    elsif params[:tech] 
        @ticket_waiting = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: params[:department], tech: current_user.tech, status: 'EN_ESPERA').where('extract(year from tickets.created_at) = ?', @current_year)
      elsif (params[:department] == "computo" && (current_user.category == "Sec COMPUTO" || current_user.category == "Admin COMPUTO")) || current_user.category == "Chuck Norris"
        @ticket_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", params[:department]], :order => "created_at DESC")
    else
    	@ticket_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_ESPERA", params[:department], 1.year.ago], :order => "created_at DESC")
    end
    @tickets = Kaminari.paginate_array(@ticket_waiting).page(params[:page])
    #if params[:department] == "computo"
      #render :layout => 'show_computer_tickets'
    #elsif params[:department] == "taller"
      #render :layout => 'show_workshop_tickets'
    #elsif params[:department] == "electronica"
      #render :layout => 'show_electronic_tickets'
    #elsif params[:department] == "mantenimiento"
      #render :layout => 'show_maintenance_tickets'
    #elsif params[:department] == "comunicacion"
      #render :layout => 'show_communication_tickets'
    #end
  end

  def show_inrevision_tickets
    if params[:tech] 
        @tickets_inrevision = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: params[:department], tech: current_user.tech, status: 'EN_REVISION').where('extract(year from tickets.created_at) = ?', @current_year)
      elsif (params[:department] == "computo" && (current_user.category == "Sec COMPUTO" || current_user.category == "Admin COMPUTO")) || current_user.category == "Chuck Norris"
        @tickets_inrevision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", params[:department]], :order => "created_at DESC")
    else
    	@tickets_inrevision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "EN_REVISION", params[:department], 1.year.ago], :order => "created_at DESC")
    end
    @tickets = Kaminari.paginate_array(@tickets_inrevision).page(params[:page])
    #if params[:department] == "computo"
      #render :layout => 'show_computer_tickets'
    #elsif params[:department] == "taller"
      #render :layout => 'show_workshop_tickets'
    #elsif params[:department] == "electronica"
      #render :layout => 'show_electronic_tickets'
    #elsif params[:department] == "mantenimiento"
      #render :layout => 'show_maintenance_tickets'
    #elsif params[:department] == "comunicacion"
      #render :layout => 'show_communication_tickets'
    #end
  end

  def show_canceled_tickets_with_search
    @search = TicketSearch.new(params[:search])
    @tickets = @search.full_scope('CANCELADO', params[:department], params[:date_from], params[:date_to])

    @tickets_notattended = @search.full_scope('NO_ATENDIDO', params[:department], params[:date_from], params[:date_to])
    @tickets_revision = @search.full_scope('EN_REVISION', params[:department], params[:date_from], params[:date_to])
    @tickets_finished = @search.full_scope('ENTREGADO', params[:department], params[:date_from], params[:date_to])
    @tickets_inprocess = @search.full_scope('EN_PROCESO', params[:department], params[:date_from], params[:date_to])
    @tickets_waiting = @search.full_scope('EN_ESPERA', params[:department], params[:date_from], params[:date_to])
    @tickets_canceled = @search.full_scope('CANCELADO', params[:department], params[:date_from], params[:date_to])
    @tickets = Kaminari.paginate_array(@tickets).page(params[:page])

  end

  def show_canceled_tickets
    if (params[:department] == "electronica" && (current_user.category == "SAC" || current_user.category == "Admin ELECTRONICA" )) || (params[:department] == "comunicacion" && current_user.category == "Admin COMUNICACION")
      @tickets_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) >= ?', "CANCELADO", params[:department], @last_year], :order => "created_at DESC")
    elsif params[:tech] 
        @tickets_canceled = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: params[:department], tech: current_user.tech, status: 'CANCELADO').where('extract(year from tickets.created_at) = ?', @current_year)
    elsif (params[:department] == "computo" && (current_user.category == "Sec COMPUTO" || current_user.category == "Admin COMPUTO")) || current_user.category == "Chuck Norris"
	@tickets_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", params[:department]], :order => "created_at DESC")
    else
    	@tickets_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND created_at >= ?', "CANCELADO", params[:department], 1.year.ago], :order => "created_at DESC")
    end
    @tickets = Kaminari.paginate_array(@tickets_canceled).page(params[:page])
    #if params[:department] == "electronica"
    #	@tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", params[:department]], :order => "created_at DESC")
    #else
    #	if params[:tech] 
     #   	@tickets = Ticket.joins(:technicians).where('department = :department AND assignments.technician_id = :tech AND status = :status', department: 'computo', tech: current_user.tech, status: 'CANCELADO').where('extract(year from tickets.created_at) = ?', @current_year)
    #	else
#		@tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) = ?', "CANCELADO", params[:department], @current_year], :order => "created_at DESC")
 #   	end
  #  end
   # @tickets = Kaminari.paginate_array(@tickets).page(params[:page])
    #if params[:department] == "computo"
      #render :layout => 'show_computer_tickets'
    #elsif params[:department] == "taller"
      #render :layout => 'show_workshop_tickets'
    #elsif params[:department] == "electronica"
      #render :layout => 'show_electronic_tickets'
    #elsif params[:department] == "mantenimiento"
      #render :layout => 'show_maintenance_tickets'
    #elsif params[:department] == "comunicacion"
      #render :layout => 'show_communication_tickets'
    #end
  end

 
  def take_ticket
   @ticket = Ticket.find(params[:id])
   @ticket.status = "EN_ESPERA"
   @ticket.taked_at = Time.now
   @ticket.save
   @assignment = Assignment.new
   @assignment.ticket_id = @ticket.id
   @assignment.technician_id = current_user.tech
   @assignment.save
   Notifier.send_reply_to_user(@ticket).deliver
   redirect_to :back
  end

  def close_ticket
   @ticket = Ticket.find(params[:id])
   if @ticket.department == "computo"
    @ticket.status = "ENTREGADO"
   else
    @ticket.status = "ENTREGADO"
   end
   @ticket.ended_at = Time.now
   @ticket.save
   Notifier.send_reply_to_user(@ticket).deliver
   redirect_to :back
  end

  def show
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @ticket }
    end
  end

  def new
    @ticket = Ticket.new
    @user = User.find(:all, :order => "lastname")
   # @category = Category.assignation(current_user.category);
    if params[:department] == 'taller' 
      #if DateTime.now < Time.local(2026,05,13,23,59) && DateTime.now > Time.local(2026,05,23,23,59)
      inicio = Time.zone.local(2026, 4, 23, 0, 0, 0)
      fin = Time.zone.local(2026, 5, 18, 23, 59, 59)
      
      if (inicio..fin).cover?(Time.zone.now)
        @category = Category.find(:all, :conditions => ['department LIKE ?', params[:department]])
      else
        @category = Category.find(:all, :conditions => ['department LIKE ? AND id != ? ', params[:department], 91])
      end
    else
      @category = Category.find(:all, :conditions => ['department LIKE ?', params[:department]])
    end
    respond_to do |format|
      format.html 
      format.json { render json: @ticket }
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @ticket.revision_old = ""
    @ticket.save
    @depto = params[:department]
    @category = Category.find(:all, :conditions => ['department LIKE ?', params[:department]])
    if current_user.category == "SAC"
	@user = User.assignation(params[:department]);
    else
	@user = User.assignation(current_user.category);
    end
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    unless current_user.login == "salma"
      @ticket.user_id = current_user.id
    end
    @ticket.status = "NO_ATENDIDO"
    respond_to do |format|
      if @ticket.save
        if @ticket.department == "computo"
          @computer_tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"])
          @ticket.folio = @computer_tickets.count 
          @ticket.save
          Notifier.send_to_computer(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to my_computer_reports_path }
          #format.html { redirect_to show_computer_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        elsif @ticket.department == "electronica"
          @electronic_tickets = Ticket.find(:all, :conditions => ['department = ?', "electronica"])
          @ticket.folio = @electronic_tickets.count
          @ticket.save
          Notifier.send_to_electronic(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          #format.html { redirect_to show_electronic_tickets_path }
          format.html { redirect_to my_electronic_reports_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        elsif @ticket.department == "comunicacion"
          @communication_tickets = Ticket.find(:all, :conditions => ['department = ?', "comunicacion"])
          @ticket.folio = @communication_tickets.count
          @ticket.save
          Notifier.send_to_communication(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to my_communication_reports_path }
          #format.html { redirect_to show_communication_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        elsif @ticket.department == "mantenimiento"
         @maintenance_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?', "mantenimiento", @current_year])
	  if @maintenance_tickets.count > 1
	    @ticket.folio = @maintenance_tickets.count.to_s 
          else
            @ticket.folio = "1"
          end
	  @ticket.save
          Notifier.send_to_maintenance(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to my_maintenance_reports_path }
          #format.html { redirect_to show_maintenance_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        elsif @ticket.department == "taller"
          @workshop_tickets = Ticket.find(:all, :conditions => ['department = ?', "taller"])
          @ticket.folio = @workshop_tickets.count + 4
          #@workshop_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?', "taller", @current_year])
            #if @workshop_tickets.count > 1
             # @ticket.folio = @workshop_tickets.count.to_s 
            #else
              #@ticket.folio = "1"
            #end
          @ticket.save
          Notifier.send_to_workshop(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to my_workshop_reports_path }
          #format.html { redirect_to show_workshop_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        if @ticket.revision.blank? 
          unless @ticket.revision_old.blank? 
	   #Actualizacion de formato de fecha 27 feb 2025
            new_revision = Time.now.strftime("%d/%m/%Y - %H:%M:%S").to_s + "\n" + @ticket.revision_old + "\n\n"
            @ticket.update_attribute :revision, new_revision 
          end  
        else 
          unless @ticket.revision_old.blank?
            info = @ticket.revision_old
            new_revision = Time.now.strftime("%d/%m/%Y - %H:%M:%S").to_s + "\n" + info + "\n\n"
            old_revision = @ticket.revision
            @ticket.update_attribute :revision, old_revision + new_revision         
          end  
        end
        if @ticket.taked_at.nil?
 	    @ticket.taked_at = Time.now
        else
        end
        @ticket.save
        if @ticket.status == "ENTREGADO"
 	    @ticket.ended_at = Time.now
        elsif @ticket.department == "computo" && @ticket.status == "EN_ESPERA" && @ticket.technicians.exists?
          Notifier.assign_to_computer(@ticket).deliver
        else
        end
        @ticket.save
        Notifier.send_reply_to_user(@ticket).deliver
        format.html { redirect_to action: 'index' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
