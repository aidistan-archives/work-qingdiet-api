class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :weixin_id
      t.string :password_digest

      t.integer :level, default: 0

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :weixin_id, unique: true
  end
end
