class AddClientStatusToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :client_status, :string
  end
end
