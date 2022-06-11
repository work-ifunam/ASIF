class Notifier < ActionMailer::Base

 def send_to_computer(ticket)
    @user = User.find(ticket.user_id)        
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @ext = ticket.ext
    @id = ticket.id
    @location = ticket.location
    @folio = ticket.folio
    @link = "computo"
    emails = Array.new
    @category.technicians.each do |tech|
      emails << tech.email + "," + " "
    end
    mail(:to => emails,
         :subject => "Tiene una nueva solicitud en ASIF - COMPUTO",
         :from => "asif@fisica.unam.mx",
         :fail_to => "asif@fisica.unam.mx"
         ) do |format|
      format.text
    end
  end

 def send_to_workshop(ticket)    
    @user = User.find(ticket.user_id)        
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @ext = ticket.ext
    @id = ticket.id
    @location = ticket.location
    @folio = ticket.folio
    @link = "taller"
    # Don't forget to change the email address to gleason@fisica.unam.mx and jperez@fisica.unam.mx

    if @category.id == 15
        mail(:to => "jperez@fisica.unam.mx, hesiquio@fisica.unam.mx",
             :subject => "Tiene una nueva solicitud en ASIF - TALLER",
             :from => "asif@fisica.unam.mx",
             :fail_to => "asif@fisica.unam.mx"
             ) do |format|
          format.text
        end
    else
        mail(:to => "jperez@fisica.unam.mx",
             :subject => "Tiene una nueva solicitud en ASIF - TALLER",
             :from => "asif@fisica.unam.mx",
             :fail_to => "asif@fisica.unam.mx"
             ) do |format|
          format.text
        end
    end
  end

 def send_to_electronic(ticket)    
    @user = User.find(ticket.user_id)        
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @ext = ticket.ext
    @id = ticket.id
    @location = ticket.location
    @folio = ticket.folio
    @link = "electronica"
    #mail(:to => "sac-if@fisica.unam.mx , mcuautle@fisica.unam.mx, jicruzm@fisica.unam.mx, jicruz@fisica.unam.mx",
    mail(:to => "jicruzm@fisica.unam.mx",
         :subject => "Tiene una nueva solicitud en ASIF - ELECTRONICA",
         :from => "asif@fisica.unam.mx",
         :fail_to => "asif@fisica.unam.mx"
         ) do |format|
      format.text
    end
  end

 def send_to_communication(ticket)    
    @user = User.find(ticket.user_id)        
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @ext = ticket.ext
    @id = ticket.id
    @location = ticket.location
    @folio = ticket.folio
    @link = "comunicacion"
    mail(:to => "lnovoa@fisica.unam.mx, sofia@fisica.unam.mx",
         :subject => "Tiene una nueva solicitud en ASIF - UNIDAD DE COMUNICACION",
         :from => "asif@fisica.unam.mx",
         :fail_to => "asif@fisica.unam.mx"
         ) do |format|
      format.text
    end
  end

 def send_to_maintenance(ticket)    
    @user = User.find(ticket.user_id)        
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @ext = ticket.ext
    @id = ticket.id
    @location = ticket.location
    @folio = ticket.folio
    @link = "mantenimiento"
    mail(:to => "mantenimiento@fisica.unam.mx",
         :subject => "Tiene una nueva solicitud en ASIF - MANTENIMIENTO",
         :from => "asif@fisica.unam.mx",
         :fail_to => "asif@fisica.unam.mx"
         ) do |format|
      format.text
    end
  end

def send_reply_to_user(ticket)    
    @status = ticket.status
    @user = User.find(ticket.user_id)        
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @id = ticket.id
    @ext = ticket.ext
    @folio = ticket.folio
    @location = ticket.location
    @revision = ticket.revision
    @message1 = "NO DEFINIDA"
    @message2 = "NO DEFINIDO"
    @techs = Array.new
    @subject = "ASIF - Actualizacion sobre Solicitud de Servicio No." + ticket.folio.to_s
    ticket.technicians.each do |tech|
      @techs << tech.firstname + " " + tech.lastname + " " + tech.email + " "
    end
    @technicians = @techs.join(",")
    if ticket.department == "computo"
      @email = ticket.user.email + "," + " " + "maricelabarrera@fisica.unam.mx, angelica@fisica.unam.mx"
      #@email = ticket.user.email 
    elsif ticket.department == "comunicacion"
      @email = ticket.user.email
    elsif ticket.department == "mantenimiento"
      @email = ticket.user.email + "," + " " + "rlazard@fisica.unam.mx, erika@fisica.unam.mx"
    elsif ticket.department == "taller"
      @email = ticket.user.email + "," + " " + "jperez@fisica.unam.mx"
    elsif ticket.department == "electronica"
      @email = Array.new
      ticket.technicians.each do |tech|
        @email << tech.email + "," + " " + "jicruzm@fisica.unam.mx"
      end
      #@email << ticket.user.email + "," + " " + "jperez@fisica.unam.mx, stea-if@fisica.unam.mx"
      @email << ticket.user.email + "," + " "
    end
    # @technician = User.find(ticket.technician)
    # @technician_complete_name = @technician.firstname + " " + @technician.lastname
    @ideal_time = ticket.ideal_time
    mail(:to => @email,
         :subject => @subject,
         :from => "asif@fisica.unam.mx",
         :fail_to => "asif@fisica.unam.mx"
         ) do |format|
      format.text
    end
  end

 def send_message(ticket)    
    # @researcher_name = user.applicant.name + " " + user.applicant.lastname
    # @researcher_category = user.applicant.category  
    # @reference_name = user.name + " " + user.lastname 
    #  mail(:to => user.email_address_with_name,

    @user = User.find(ticket.user_id)    
    @category = Category.find(ticket.category)    
    @description = ticket.description
    @ext = ticket.ext
    @location = ticket.location

    mail(:to => "daniel@fisica.unam.mx",
         :subject => "Solicitud de Servicio",
         :from => "asif@fisica.unam.mx",
         :fail_to => "asif@fisica.unam.mx"
         ) do |format|
      format.text
    end
  end

end
