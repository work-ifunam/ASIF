class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :ticket_id
      t.integer :technician_id

      t.timestamps
    end
  end
end
