class AddEndedAtToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :ended_at, :datetime
  end
end
