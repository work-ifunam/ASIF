class AddTechnicianIdToAssignation < ActiveRecord::Migration
  def change
    add_column :assignations, :technician_id, :integer
  end
end
