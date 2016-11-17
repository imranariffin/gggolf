class ChangeTournamentColumnNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :tournaments, :start, :start_datetime
    rename_column :tournaments, :end, :end_datetime
  end
end
