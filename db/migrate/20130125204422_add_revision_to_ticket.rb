class AddRevisionToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :revision, :text
  end
end
