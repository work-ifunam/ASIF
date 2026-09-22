class CreateServerTokens < ActiveRecord::Migration
  def change
    create_table :server_tokens do |t|
      t.string :name
      t.string :token
      
      t.timestamps
    end
    
    add_index :server_tokens, :token, unique: true
  end
end
