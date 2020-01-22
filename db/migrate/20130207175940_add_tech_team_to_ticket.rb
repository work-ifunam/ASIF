class AddTechTeamToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :tech_team, :text
  end
end
