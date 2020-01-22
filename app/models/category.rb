class Category < ActiveRecord::Base
  attr_accessible :name, :department
  has_many :assignations
  has_many :technicians, :through => :assignations
  def self.assignation(department)
    if department.eql?("Admin COMPUTO") || department.eql?("Personal COMPUTO")
       return Category.find(:all,:conditions => 'department = "computo"')
    elsif department.eql?("Admin ELECTRONICA") || department.eql?("Personal ELECTRONICA")
       return Category.find(:all,:conditions => 'department  = "electronica"') 
    elsif department.eql?("Admin TALLER") || department.eql?("Personal TALLER")
       return Category.find(:all,:conditions => 'department  = "taller"') 
    elsif department.eql?("Admin COMUNICACION") || department.eql?("Personal COMUNICACION")
       return Category.find(:all,:conditions => 'department  = "comunicacion"') 
    elsif department.eql?("Admin Mantenimiento") || department.eql?("Personal Mantenimiento")
       return Category.find(:all,:conditions => 'department  = "mantenimiento"') 
    else
       return Category.find(:all,:condition => 'department = "null"')
    end
  end
end
