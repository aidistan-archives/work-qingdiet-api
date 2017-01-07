class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :uuid
      t.references :app
      t.references :user
      t.integer :expires_in
      t.datetime :expired_at
      t.string :last_called_ip
      t.datetime :last_called_at

      t.timestamps
    end
    add_index :tokens, :uuid, unique: true
  end
end
