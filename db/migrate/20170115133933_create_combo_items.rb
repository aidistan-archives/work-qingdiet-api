class CreateComboItems < ActiveRecord::Migration[5.0]
  def change
    create_table :combo_items do |t|
      t.references :dish, foreign_key: true
      t.references :combo, foreign_key: true

      t.timestamps
    end
  end
end
