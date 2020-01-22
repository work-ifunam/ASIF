class AddTechToUser < ActiveRecord::Migration
  def change
    add_column :users, :tech, :integer
  end
end
