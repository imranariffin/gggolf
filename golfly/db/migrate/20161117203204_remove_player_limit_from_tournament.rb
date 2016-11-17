class RemovePlayerLimitFromTournament < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :player_limit, :integer
  end
end
