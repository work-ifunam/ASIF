class AddDepartmentToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :department, :string
  end
end
