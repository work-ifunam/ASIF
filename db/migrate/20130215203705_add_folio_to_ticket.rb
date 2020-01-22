class AddFolioToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :folio, :integer
  end
end
