class AddRequiredTournamentFields < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :is_private, :boolean
    add_column :tournaments, :golf_format, :string
    add_column :tournaments, :schedule, :text
    add_column :tournaments, :features, :text
    add_column :tournaments, :email, :string
    add_column :tournaments, :phone, :string
  end
end
