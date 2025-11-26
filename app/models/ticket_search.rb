class TicketSearch < ActiveRecord::Base

  attr_reader :date_from, :date_to, :department, :category, :category_name, :tech, :technicians, :technician_name, :folio

  def initialize(params)
   params ||= {}
      @date_from = parsed_date(params[:date_from], 1.year.ago.to_date.strftime("%d/%m/%Y").to_s) 
      @date_to = parsed_date(params[:date_to], Date.today.strftime("%d/%m/%Y").to_s)
      @department = params[:department].to_s 
      @category = params[:category].to_s
      @technicians = params[:technicians].to_s
      if params[:folio].present?
      	@folio = params[:folio].to_s
      else
      	@folio = nil
      end
      if params[:category].present?
         @category_names = Category.where('id = ? ', @category).pluck(:name)
         #@category_names = Category.where('id = ? ', @category).pluck(:name)
         @category_name = @category_names[0]
      else
         @category_name = 'Todas las Solicitudes'
      end
      if params[:technicians].present?
         @technician_names = Technician.where('id = ? ', @technicians).pluck(:firstname)
         @technician_name = @technician_names[0]
         #@technician_name = 'Uno'
      else
         @technician_name = 'Todos'
      end
      if params[:tech].present?
         @tech = params[:tech].to_s
      end
  end

  def scope_with_folio(department, folio)
   logger.debug "--------------------------------------"
   logger.debug "SCOPE FOLIO"
   logger.debug "--------------------------------------"
   @department = department
   Ticket.where('folio = ? AND department = ?', @folio, @department)
  end

  def scope(department)
   logger.debug "--------------------------------------"
   logger.debug "SCOPE"
   logger.debug "--------------------------------------"
   @department = department
   if @category != ''
	Ticket.where('category = ? AND department = ?  AND created_at BETWEEN ? AND ?', @category, @department, @date_from.to_date, @date_to.to_date.end_of_day.to_s ).order("created_at DESC")
   else 
	Ticket.where('department = ?  AND created_at BETWEEN ? AND ?', @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   end
  end
  
  #Filtrar a partir de parametros recibidos en la busqueda
  def advanced_scope(department)
   @department = department
   if @category != ''
	if @technicians !=''
	    logger.debug "--------------------------------------"
	    logger.debug "ADVANCED SCOPE WITH TECHNICIAN AND CATEGORY"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
      	    Ticket.joins(:technicians).where('tickets.category = ? AND department = ? AND technician_id = ? AND tickets.created_at BETWEEN ? AND ?', @category, @department, @technicians, @date_from, @date_to).order('tickets.created_at DESC')
	else
	    logger.debug "--------------------------------------"
	    logger.debug "ADVANCED SCOPE WITHOUT TECHNICIAN BUT WITH CATEGORY"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
	    Ticket.where('category = ? AND department = ?  AND created_at BETWEEN ? AND ?', @category, @department, @date_from.to_date, @date_to.to_date.end_of_day.to_s ).order("created_at DESC")
	end
   elsif @category =='' && @technicians !=''
	    logger.debug "--------------------------------------"
	    logger.debug "ADVANCED SCOPE WITH TECHNICIAN BUT WITHOUT CATEGORY"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
      	    Ticket.joins(:technicians).where('department = ? AND technician_id = ? AND tickets.created_at BETWEEN ? AND ?', @department, @technicians, @date_from, @date_to).order('tickets.created_at DESC')
   else
      logger.debug "--------------------------------------"
      logger.debug "ALL THE DATA FROM advanced_scope L57"
      Ticket.where('department = ?  AND created_at BETWEEN ? AND ?', @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   end
  end

  #Filtrar a partir de parametros recibidos en la busqueda y estatus de solicitud
  def advanced_scope_with_status(status, department)
   @status = status
   @department = department
   if @folio != nil
	logger.debug "--------------------------------------"
	logger.debug "ADVANCED SCOPE WITH FOLIO"
	logger.debug "-Folio: #{@folio}"
	logger.debug "-Department: #{@department}"
	logger.debug "-Status: #{@status}"
   	Ticket.where('folio = ? AND department = ? AND status = ?', @folio, @department, @status)
   elsif @category != ''
	if @technicians !=''
	    logger.debug "--------------------------------------"
	    logger.debug "ADVANCED SCOPE WITH TECHNICIAN AND CATEGORY"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
      	    Ticket.joins(:technicians).where('status = ? AND tickets.category = ? AND department = ? AND technician_id = ? AND tickets.created_at BETWEEN ? AND ?', @status, @category, @department, @technicians, @date_from, @date_to).order('tickets.created_at DESC')
	else
	    logger.debug "--------------------------------------"
	    logger.debug "ADVANCED SCOPE WITHOUT TECHNICIAN BUT WITH CATEGORY"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
	    Ticket.where('status = ? AND category = ? AND department = ?  AND created_at BETWEEN ? AND ?', @status, @category, @department, @date_from.to_date, @date_to.to_date.end_of_day.to_s ).order("created_at DESC")
	end
   elsif @category =='' && @technicians !=''
	    logger.debug "--------------------------------------"
	    logger.debug "ADVANCED SCOPE WITH TECHNICIAN BUT WITHOUT CATEGORY"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
      	    Ticket.joins(:technicians).where('status = ? AND department = ? AND technician_id = ? AND tickets.created_at BETWEEN ? AND ?', @status, @department, @technicians, @date_from, @date_to).order('tickets.created_at DESC')
   else
      logger.debug "--------------------------------------"
      logger.debug "ALL THE DATA FROM advanced_scope_with_status L90"
      Ticket.where('status = ? AND department  = ? AND created_at BETWEEN ? AND ?', @status, @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   end
  end

  def scope_status(status, department)
   @status = status
   @department = department
   if @category != ''
      Ticket.where('category = ? AND status = ? AND department  = ? AND created_at BETWEEN ? AND ?', @category, @status, @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   else
      Ticket.where('status = ? AND department  = ? AND created_at BETWEEN ? AND ?', @status, @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   end
   end

  def advanced_scope_status(status, department)
   @status = status
   @department = department
   if @category != ''
      Ticket.where('category = ? AND status = ? AND department  = ? AND created_at BETWEEN ? AND ?', @category, @status, @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   elsif @technicians != ''
         Ticket.joins(:technicians).where('technician_id = ? AND status = ? AND tickets.created_at BETWEEN ? AND ?', @technicians, @status, @date_from, @date_to).order('tickets.created_at DESC')
   else
      Ticket.where('status = ? AND department  = ? AND created_at BETWEEN ? AND ?', @status, @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
   end
   end

   def full_scope(cat, department, date_from, date_to)
      @category = cat
      @department = department
      @date_from = date_from
      @date_to = date_to
      if @category != ''
         Ticket.where('category = ? AND department  = ? AND created_at BETWEEN ? AND ?', @category, @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
      else
         Ticket.where('department  = ? AND created_at BETWEEN ? AND ?', @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
      end
   end

  #Generar la busqueda para la generacion y descarga del archivo xls
   def tech_full_scope(cat, department, date_from, date_to, tech_id)
      @category = cat
      @department = department
      @date_from = date_from
      @date_to = date_to
      @technicians = tech_id
	    logger.debug "----------------------------------------"
	    logger.debug "DOWNLOAD XLS"
	    logger.debug "-Technician: #{@technicians}"
	    logger.debug "-Department: #{@department}"
	    logger.debug "-Category: #{@category}"
	    logger.debug "----------------------------------------"
      if @category != ''
	 if @technicians !=''
	    logger.debug "DOWNLOAD CATEGORY AND TECHNICIANS"
      	    Ticket.joins(:technicians).where('tickets.category = ? AND department = ? AND technician_id = ? AND tickets.created_at BETWEEN ? AND ?', @category, @department, @technicians, @date_from.to_date, @date_to.to_date.end_of_day.to_s).order('tickets.created_at DESC')
	 else
	    logger.debug "DOWNLOAD ONY CATEGORY"
	    Ticket.where('category = ? AND department = ?  AND created_at BETWEEN ? AND ?', @category, @department, @date_from.to_date, @date_to.to_date.end_of_day.to_s ).order("created_at DESC")
	 end
      elsif @category =='' && @technicians !=''
	    logger.debug "DOWNLOAD ONY TECHNICIANS"
      	    relation = Ticket.joins(:technicians).where('department = ? AND technician_id = ? AND tickets.created_at BETWEEN ? AND ?', @department, @technicians, @date_from.to_date, @date_to.to_date.end_of_day.to_s).order('tickets.created_at DESC')
	    logger.debug "SQL Query: #{relation.to_sql}"
	    return relation
      else
	    logger.debug "DOWNLOAD ALL"
      	    Ticket.where('department = ?  AND created_at BETWEEN ? AND ?', @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
      end
   end

   def tech_scope(department, tech_id)
      @department = department
      @tech = tech_id
      if @category.present?
         Ticket.joins(:technicians).where('category = ? AND department = ? AND technicians.id = ? AND tickets.created_at BETWEEN ? AND ?', @category, @department, @tech, @date_from.to_date, @date_to.to_date.end_of_day.to_s).order('tickets.created_at DESC')
      else
         Ticket.joins(:technicians).where('department = ? AND technicians.id = ? AND tickets.created_at BETWEEN ? AND ?', @department, @tech, @date_from.to_date, @date_to.to_date.end_of_day.to_s).order('tickets.created_at DESC')
      end
   end

  private

  def parsed_date(date_string, default)
   #Date.parse(date_string).strftime("%d-%m-%Y")
   Date.parse(date_string)
   rescue ArgumentError, TypeError
   default
  end


end
