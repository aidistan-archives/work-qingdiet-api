class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :consignee
      t.string :province
      t.string :city
      t.string :district
      t.string :town
      t.string :detail
      t.string :mobile
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
