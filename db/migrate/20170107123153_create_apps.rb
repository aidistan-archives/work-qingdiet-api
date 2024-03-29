class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.integer :level

      t.string :client_id
      t.string :client_secret
      t.text :redirect_uri

      t.timestamps
    end
    add_index :apps, :name, unique: true
    add_index :apps, :client_id, unique: true
  end
end
