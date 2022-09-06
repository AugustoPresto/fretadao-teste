class RenameProfilesToUsers < ActiveRecord::Migration[6.1]
  def up
    rename_table :profiles, :users
  end

  def down
    rename_table :users, :profiles
  end
end
