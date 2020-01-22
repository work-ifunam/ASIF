class Technician < ActiveRecord::Base
  attr_accessible :category, :email, :firstname, :lastname
  has_many :assignations
  has_many :categories, :through => :assignations
  has_many :assignments
  has_many :tickets, :through => :assignments

  def self.assignation(department)
    if department.eql?("Admin COMPUTO")
       return Technician.find(:all,:conditions => 'category LIKE "%computo%"')
    elsif department.eql?("Admin ELECTRONICA")
       return Technician.find(:all,:conditions => 'category LIKE "%electronica%"')
    elsif department.eql?("Admin TALLER")
       return Technician.find(:all,:conditions => 'category LIKE "%taller%"')
    elsif department.eql?("Admin COMUNICACION")
       return Technician.find(:all,:conditions => 'category LIKE "%comunicacion%"')
    elsif department.eql?("Admin Mantenimiento")
       return Technician.find(:all,:conditions => 'category LIKE "%mantenimiento%"')
    else
       return Technician.find(:all,:condition => 'department = "null"')
    end
  end


end
