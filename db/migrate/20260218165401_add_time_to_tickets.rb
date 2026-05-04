class AddTimeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :schedule_time, :time
  end
end
