class AddWebsiteToSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :website, :string
  end
end
