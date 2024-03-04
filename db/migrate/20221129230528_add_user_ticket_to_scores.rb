class AddUserTicketToScores < ActiveRecord::Migration
  def change
    add_column :scores, :ticket_id, :integer, references: :tickets
  end
end
