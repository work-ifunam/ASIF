class Ticket < ActiveRecord::Base
    attr_accessible :category, :description, :priority, :status, :technician, :user_id, :id
    belongs_to :user

    #Preguntaer si los tickets que se veran son los creados por el mismo usuario o quienes ven estos tickets
    def self.user(department)
       if department.eql?("Admin COMPUTO")  || department.eql?("Personal COMPUTO")
          return Ticket.all
       elsif department.eql?("Admin ELECTRONICA") || department.eql?("Personal ELECTRONICA") 
          return Ticket.all
       else
          return Category.find(:all,:conditions => 'department = "null"')
       end
    end

end
