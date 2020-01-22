class CreateTechnicians < ActiveRecord::Migration
  def change
    create_table :technicians do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :category

      t.timestamps
    end
  end
end
