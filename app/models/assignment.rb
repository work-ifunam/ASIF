class Assignment < ActiveRecord::Base
  attr_accessible :technician_id, :ticket_id
  belongs_to :ticket
  belongs_to :technician
end
