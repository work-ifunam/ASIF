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
        elsif @ticket.department == "comunicacion"
          @communication_tickets = Ticket.find(:all, :conditions => ['department = ?', "comunicacion"])
          @ticket.folio = @communication_tickets.count
          @ticket.save
          Notifier.send_to_communication(@ticket).deliver
          flash[:notice] = "SU SOLICITUD HA SIDO CREADA"
          format.html { redirect_to show_communication_tickets_path }
          format.json { render json: @ticket, status: :created, location: @ticket }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

end  #Controller
