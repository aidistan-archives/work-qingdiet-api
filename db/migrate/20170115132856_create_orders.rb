class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0

      t.string :addr_consignee
      t.string :addr_mobile
      t.string :addr_province
      t.string :addr_city
      t.string :addr_district
      t.string :addr_town
      t.string :addr_detail

      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
