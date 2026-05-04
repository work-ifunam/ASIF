class User < ActiveRecord::Base
  acts_as_authentic do |c|
  end
  attr_accessible :category, :email, :firstname, :lastname, :password, :password_confirmation, :id, :tech, :login
  has_many :tickets
  has_many :assignations
  has_many :categories, :through => :assignations
  has_one :score

  def self.assignation(department)
    if department.eql?("Admin COMPUTO") || department.eql?("Sec COMPUTO")
       return User.find(:all,:conditions => 'category LIKE "%computo%"')
    elsif department.eql?("Admin ELECTRONICA")
       return User.find(:all,:conditions => 'category LIKE "%electronica%"')
    elsif department.eql?("Admin TALLER")
       return User.find(:all,:conditions => 'category LIKE "%taller%"')
    elsif department.eql?("Personal TALLER")
       return User.find(:all,:conditions => 'category LIKE "%taller%"')
    elsif department.eql?("Admin COMUNICACION")
       return User.find(:all,:conditions => 'category LIKE "%comunicacion%"')
    elsif department.eql?("Admin MANTENIMIENTO")
       return User.find(:all,:conditions => 'category LIKE "%mantenimiento%"')
    elsif department.eql?("Admin SERVICIOS")
       return User.find(:all,:conditions => 'category LIKE "%servicios%"')
    elsif department.eql?("comunicacion")
       return User.find(:all,:conditions => 'category LIKE "%comunicacion%"')
    elsif department.eql?("electronica")
       return User.find(:all,:conditions => 'category LIKE "%electronica%"')
    else
       return User.find(:all,:condition => 'department = "null"')
    end
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end

