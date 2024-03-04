class Api::InfoController < ApplicationController
    include ActionController::MimeResponds

  def index
    self.response_body = "Hello World!"
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    unless current_user.login == "angelica"
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

end  #Controller
