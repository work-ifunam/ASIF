class AddLocationToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :location, :string
  end
end
