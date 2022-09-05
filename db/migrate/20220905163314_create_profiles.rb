class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :nickname
      t.string :github_url
      t.integer :followers
      t.integer :following
      t.integer :stars
      t.integer :last_year_contributions
      t.string :avatar_url
      t.string :organization
      t.string :location

      t.timestamps
    end
  end
end
