class AddIdealTimeToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :ideal_time, :datetime
  end
end
