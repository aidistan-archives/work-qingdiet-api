class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.integer :level, default: 0

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
