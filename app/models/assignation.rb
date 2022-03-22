class Assignation < ActiveRecord::Base
  attr_accessible :category_id, :user_id, :id, :department, :technician_id
  belongs_to :technician
  belongs_to :category
  def self.user(department)
    if department.eql?("Admin COMPUTO")
      return Assignation.find(:all,:include => :user,:include => :category,:conditions => 'department = "computo"') 
    elsif department.eql?("Admin ELECTRONICA")
      return Assignation.find(:all,:include => :user,:include => :category,:conditions => 'department = "electronica"')
    elsif department.eql?("Admin TALLER")
      return Assignation.find(:all,:include => :user,:include => :category,:conditions => 'department = "taller"')
    elsif department.eql?("Admin COMUNICACION")
      return Assignation.find(:all,:include => :user,:include => :category,:conditions => 'department = "comunicacion"')
    elsif department.eql?("Admin MANTENIMIENTO")
      return Assignation.find(:all,:include => :user,:include => :category,:conditions => 'department = "mantenimiento"')
    elsif department.eql?("Admin SERVICIOS")
      return Assignation.find(:all,:include => :user,:include => :category,:conditions => 'department = "servicios"')
    else
      return Assignation.find(:all,:condition => 'department = "null"')
    end
  end
end
