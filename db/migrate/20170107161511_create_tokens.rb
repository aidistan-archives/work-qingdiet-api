class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :uuid
      t.integer :kind, default: 0

      t.integer :expires_in
      t.datetime :expired_at
      t.string :last_used_ip
      t.datetime :last_used_at
      t.timestamps

      t.references :app, foreign_key: true
      t.references :user, foreign_key: true
    end
    add_index :tokens, :uuid, unique: true
  end
end
