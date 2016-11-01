class RenameTypeColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :ticket_options, :type, :ttype
    rename_column :reg_sponsors, :type, :ttype
    rename_column :sponsor_options, :type, :ttype
  end
end
