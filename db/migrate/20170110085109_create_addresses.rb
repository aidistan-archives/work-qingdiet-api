class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :consignee
      t.string :mobile

      t.string :province
      t.string :city
      t.string :district
      t.string :town
      t.string :detail

      t.datetime :last_used_at
      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
