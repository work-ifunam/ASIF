class AddRevisionOldToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :revision_old, :text
  end
end
