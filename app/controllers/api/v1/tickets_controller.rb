module Api
  module V1
    class TicketsController < ApplicationController
	respond_to :json

	def index
    	  self.response_body = "Hello World!"
  	end

  	def create
	  # Se extrae el email del hash params antes de que Ticket intente asignarlo
	  user_email = params[:ticket].delete(:email) 
    	  @ticket = Ticket.new(params[:ticket])
	  # Se busca el id de la categoría, probablemente esto cambie por un id
	  #@ticket_category = Category.where("name LIKE ?", @ticket.category).first
      	  #@ticket.category = @ticket_category.id
	  @ticket_user = User.where("email LIKE ?", user_email).first
      	  @ticket.user_id = @ticket_user.id

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

      private
      
      def authenticate_api_request
        api_token = request.headers['X-API-Token']
        @api_server = ServerToken.find_by_token(api_token)
        
        unless @api_server
          render json: { error: 'Unauthorized' }, status: :unauthorized
          return false
        end
        
        @api_user_id = User.find_by_email('api@eventos.fisica.unam.mx').id
      end

    end
  end
end  #Controller
