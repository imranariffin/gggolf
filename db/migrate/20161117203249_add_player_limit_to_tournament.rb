class AddPlayerLimitToTournament < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :player_limit, :integer
  end
end
