class AddTakedAtToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :taked_at, :datetime
  end
end
