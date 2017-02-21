class CreateCombos < ActiveRecord::Migration[5.0]
  def change
    create_table :combos do |t|
      t.timestamps

      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.references :requirement, foreign_key: true, index: { unique: true }
    end
  end
end
