class CreateBitlinks < ActiveRecord::Migration[6.1]
  def change
    create_table :bitlinks do |t|
      t.string :short_url
      t.string :long_url
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
