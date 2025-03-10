class AddUserToScores < ActiveRecord::Migration
  def change
    add_column :scores, :user_id, :integer, references: :users
  end
end
