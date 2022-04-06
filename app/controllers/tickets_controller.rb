class TicketsController < ApplicationController

  before_filter :require_user, :current_year
  
  def index
    tickets = Ticket.user(current_user.category)
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])

    if current_user.category == "Admin COMPUTO" || current_user.category == "Personal COMPUTO" || current_user.category == "Chuck Norris"
      #@computer_tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"])
      @computer_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"computo", @current_year])
      @computer_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","computo", @current_year])
      @computer_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","computo", @current_year])
      @computer_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","computo", @current_year])
      @computer_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","computo", @current_year])
      @computer_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","computo", @current_year])
      @computer_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","computo", @current_year])
    elsif current_user.category == "Admin ELECTRONICA" || current_user.category == "Personal ELECTRONICA"
      @electronic_tickets = Ticket.find(:all, :conditions => ['department = ?', "electronica"])
      @electronic_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", "electronica"])
      @electronic_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", "electronica"])
      @electronic_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", "electronica"])
      @electronic_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", "electronica"])
      @electronic_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", "electronica"])
      @electronic_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", "electronica"])
    elsif current_user.category == "Admin TALLER" || current_user.category == "Personal TALLER"
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
    elsif current_user.category == "Admin MANTENIMIENTO" || current_user.category == "Personal MANTENIMIENTO"
      @maintenance_tickets = Ticket.find(:all, :conditions => ['department = ?', "mantenimiento"])
      @maintenance_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","mantenimiento", @current_year])
      @maintenance_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","mantenimiento", @current_year])
      @maintenance_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","mantenimiento", @current_year])
      @maintenance_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","mantenimiento", @current_year])
      @maintenance_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","mantenimiento", @current_year])
      @maintenance_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","mantenimiento", @current_year])
    elsif current_user.category == "Admin SERVICIO" || current_user.category == "Personal SERVICIO"
      @servicio_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"servicio", @current_year])
      @servicio_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","servicio", @current_year])
      @servicio_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","servicio", @current_year])
      @servicio_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","servicio", @current_year])
      @servicio_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","servicio", @current_year])
      @servicio_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","servicio", @current_year])
      @servicio_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","servicio", @current_year])
    elsif current_user.category == "Admin COMUNICACION" || current_user.category == "Personal COMUNICACION"
      @communication_tickets = Ticket.find(:all, :conditions => ['department = ? AND extract(year  from created_at) = ?',"comunicacion", @current_year])
      @communication_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","comunicacion", @current_year])
      @communication_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","comunicacion", @current_year])
      @communication_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","comunicacion", @current_year])
      @communication_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","comunicacion", @current_year])
      @communication_waiting= Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","comunicacion", @current_year])
      @communication_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","comunicacion", @current_year])
    end  
   respond_to do |format|
      format.html 
      format.json { render json: @tickets }
    end
  end

#Show Department Tickets
  def show_computer_tickets
    tickets = Ticket.find(:all, :conditions => ['department = ?', "computo"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
     @computer_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","computo", @current_year])
     @computer_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","computo", @current_year])
     @computer_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","computo", @current_year])
     @computer_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","computo", @current_year])
     @computer_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","computo", @current_year])
     @computer_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","computo", @current_year])
    render :layout => 'show_computer_tickets'
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
    tickets = Ticket.find(:all, :conditions => ['department = ?', "mantenimiento"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
     @maintenance_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","mantenimiento", @current_year])
     @maintenance_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","mantenimiento", @current_year])
     @maintenance_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","mantenimiento", @current_year])
     @maintenance_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","mantenimiento", @current_year])
     @maintenance_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","mantenimiento", @current_year])
     @maintenance_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","mantenimiento", @current_year])
    render :layout => 'show_maintenance_tickets'
  end  

  def show_communication_tickets
    tickets = Ticket.find(:all, :conditions => ['department = ?', "comunicacion"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
     @communication_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "NO_ATENDIDO","comunicacion", @current_year])
     @communication_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_REVISION","comunicacion", @current_year])
     @communication_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "ENTREGADO","comunicacion", @current_year])
     @communication_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_PROCESO","comunicacion", @current_year])
     @communication_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "EN_ESPERA","comunicacion", @current_year])
     @communication_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year  from created_at) = ?', "CANCELADO","comunicacion", @current_year])
    render :layout => 'show_communication_tickets'
  end  

  def show_electronic_tickets
    tickets = Ticket.find(:all, :conditions => ['department = ?', "electronica"], :order => "created_at DESC")
    @tickets = Kaminari.paginate_array(tickets).page(params[:page])
    @electronic_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", "electronica"])
    @electronic_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", "electronica"])
    @electronic_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", "electronica"])
    @electronic_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", "electronica"])
    @electronic_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", "electronica"])
    @electronic_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", "electronica"])
    render :layout => 'show_electronic_tickets'
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
    @workshop_revision = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", "taller"])
    @workshop_finished = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "ENTREGADO", "taller"])
    @workshop_inprocess = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", "taller"])
    @workshop_notattended = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", "taller"])
    @workshop_waiting = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", "taller"])
    @workshop_canceled = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "CANCELADO", "taller"])
    render :layout => 'show_workshop_tickets'
  end   

#End Department Tickets
#Show Status Tickets

  def show_inprocess_tickets
    @tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_PROCESO", params[:department]], :order => "created_at DESC")
    if params[:department] == "computo"
      render :layout => 'show_computer_tickets'
    elsif params[:department] == "taller"
      render :layout => 'show_workshop_tickets'
    elsif params[:department] == "electronica"
      render :layout => 'show_electronic_tickets'
    elsif params[:department] == "mantenimiento"
      render :layout => 'show_maintenance_tickets'
    elsif params[:department] == "comunicacion"
      render :layout => 'show_communication_tickets'
    end
  end

  def show_unattended_tickets
    @tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "NO_ATENDIDO", params[:department]], :order => "created_at DESC")
    if params[:department] == "computo"
      render :layout => 'show_computer_tickets'
    elsif params[:department] == "taller"
      render :layout => 'show_workshop_tickets'
    elsif params[:department] == "electronica"
      render :layout => 'show_electronic_tickets'
    elsif params[:department] == "mantenimiento"
      render :layout => 'show_maintenance_tickets'
    elsif params[:department] == "comunicacion"
      render :layout => 'show_communication_tickets'
    end
  end

  def show_attended_tickets
    @tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) = ?', "ENTREGADO", params[:department], @current_year], :order => "created_at DESC")
    if params[:department] == "computo"
      render :layout => 'show_computer_tickets'
    elsif params[:department] == "taller"
      render :layout => 'show_workshop_tickets'
    elsif params[:department] == "electronica"
      render :layout => 'show_electronic_tickets'
    elsif params[:department] == "mantenimiento"
      render :layout => 'show_maintenance_tickets'
    elsif params[:department] == "comunicacion"
      render :layout => 'show_communication_tickets'
    end
  end

  def show_froze_tickets
    @tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_ESPERA", params[:department]], :order => "created_at DESC")
    if params[:department] == "computo"
      render :layout => 'show_computer_tickets'
    elsif params[:department] == "taller"
      render :layout => 'show_workshop_tickets'
    elsif params[:department] == "electronica"
      render :layout => 'show_electronic_tickets'
    elsif params[:department] == "mantenimiento"
      render :layout => 'show_maintenance_tickets'
    elsif params[:department] == "comunicacion"
      render :layout => 'show_communication_tickets'
    end
  end

  def show_inrevision_tickets
    @tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ?', "EN_REVISION", params[:department]], :order => "created_at DESC")
    if params[:department] == "computo"
      render :layout => 'show_computer_tickets'
    elsif params[:department] == "taller"
      render :layout => 'show_workshop_tickets'
    elsif params[:department] == "electronica"
      render :layout => 'show_electronic_tickets'
    elsif params[:department] == "mantenimiento"
      render :layout => 'show_maintenance_tickets'
    elsif params[:department] == "comunicacion"
      render :layout => 'show_communication_tickets'
    end
  end

  def show_canceled_tickets
    @tickets = Ticket.find(:all, :conditions => ['status = ? AND department = ? AND extract(year from created_at) = ?', "CANCELADO", params[:department], @current_year], :order => "created_at DESC")
    if params[:department] == "computo"
      render :layout => 'show_computer_tickets'
    elsif params[:department] == "taller"
      render :layout => 'show_workshop_tickets'
    elsif params[:department] == "electronica"
      render :layout => 'show_electronic_tickets'
    elsif params[:department] == "mantenimiento"
      render :layout => 'show_maintenance_tickets'
    elsif params[:department] == "comunicacion"
      render :layout => 'show_communication_tickets'
    end
  end

 
  def take_ticket
   @ticket = Ticket.find(params[:id])
   @ticket.status = "EN_PROCESO"
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
    @category = Category.find(:all, :conditions => ['department LIKE ?', params[:department]])
    respond_to do |format|
      format.html 
      format.json { render json: @ticket }
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @ticket.revision_old = ""
    @ticket.save
    @category = Category.find(:all, :conditions => ['department LIKE ?', params[:department]])
    @user = User.assignation(current_user.category);
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
          format.html { redirect_to show_computer_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        elsif @ticket.department == "electronica"
          @electronic_tickets = Ticket.find(:all, :conditions => ['department = ?', "electronica"])
          @ticket.folio = @electronic_tickets.count
          @ticket.save
          Notifier.send_to_electronic(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to show_electronic_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        elsif @ticket.department == "comunicacion"
          @communication_tickets = Ticket.find(:all, :conditions => ['department = ?', "comunicacion"])
          @ticket.folio = @communication_tickets.count
          @ticket.save
          Notifier.send_to_communication(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to show_communication_tickets_path }
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
          format.html { redirect_to show_maintenance_tickets_path }
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
          format.html { redirect_to show_workshop_tickets_path }
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
            new_revision = Time.now.strftime("%m/%d/%Y - %H:%M:%S").to_s + "\n" + @ticket.revision_old + "\n\n"
            @ticket.update_attribute :revision, new_revision 
          end  
        else 
          unless @ticket.revision_old.blank?
            info = @ticket.revision_old
            new_revision = Time.now.strftime("%m/%d/%Y - %H:%M:%S").to_s + "\n" + info + "\n\n"
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
