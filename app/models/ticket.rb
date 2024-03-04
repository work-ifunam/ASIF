class Ticket < ActiveRecord::Base
  attr_accessible :category, :description, :priority, :status, :technician, :user_id, :id, :department, :revision, :ideal_time, :revision_old, :folio, :ext, :location
  belongs_to :user
  has_many :assignments
  has_many :technicians, :through => :assignments
  has_one :score
  
  attr_accessible :technician_ids

  def technicians_symbols  
    technicians.map do |technician|  
      Technician.firstname.underscore.to_sym  
    end  
  end  


    def self.user(department)
       if department.eql?("Chuck Norris")
          return Ticket.all       
       elsif department.eql?("Admin COMPUTO")  || department.eql?("Personal COMPUTO")
          return Ticket.find(:all, :conditions => 'department = "computo"', :order => "created_at DESC")
       elsif department.eql?("Admin ELECTRONICA") || department.eql?("Personal ELECTRONICA") || department.eql?("SAC") 
          return Ticket.find(:all, :conditions => 'department = "electronica"', :order => "created_at DESC")
       elsif department.eql?("Admin TALLER") || department.eql?("Personal TALLER") 
          return Ticket.find(:all, :conditions => 'department = "taller"', :order => "created_at DESC")
       elsif department.eql?("Admin COMUNICACION") || department.eql?("Personal COMUNICACION") || department.eql?("SAC") 
          return Ticket.find(:all, :conditions => 'department = "comunicacion"', :order => "created_at DESC")
       elsif department.eql?("Admin MANTENIMIENTO") || department.eql?("Personal MANTENIMIENTO") 
          return Ticket.find(:all, :conditions => 'department = "mantenimiento"', :order => "created_at DESC")
       elsif department.eql?("Admin SERVICIOS") || department.eql?("Personal SERVICIOS") 
          return Ticket.find(:all, :conditions => 'department = "servicios"', :order => "created_at DESC")
       else
          return Category.find(:all,:conditions => 'department = "null"')
       end
    end

end
