class AddLogoToSponsors < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :logo, :string
  end
end
