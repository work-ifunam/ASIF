class TicketSearch < ActiveRecord::Base

  attr_reader :date_from, :date_to, :department, :category, :category_name

  def initialize(params)
   params ||= {}
      @date_from = parsed_date(params[:date_from], 1.year.ago.to_date.strftime("%d/%m/%Y").to_s) 
      @date_to = parsed_date(params[:date_to], Date.today.strftime("%d/%m/%Y").to_s)
      @department = params[:department].to_s 
      @category = params[:category].to_s
      if params[:category].present?
         @category_names = Category.where('id = ? ', @category).pluck(:name)
         @category_name = @category_names[0]
      else
         @category_name = 'Solicitudes Totales'
      end
  end

  def scope(department)
   @department = department
   if @category != ''
      Ticket.where('category = ? AND department = ?  AND created_at BETWEEN ? AND ?', @category, @department, @date_from.to_date, @date_to.to_date.end_of_day.to_s ).order("created_at DESC")
   else 
      Ticket.where('department = ?  AND created_at BETWEEN ? AND ?', @department, @date_from.to_date, @date_to.to_date.end_of_day).order("created_at DESC")
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

  private

  def parsed_date(date_string, default)
   #Date.parse(date_string).strftime("%d-%m-%Y")
   Date.parse(date_string)
   rescue ArgumentError, TypeError
   default
  end

end
