class AddExtensionToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :ext, :string
  end
end
