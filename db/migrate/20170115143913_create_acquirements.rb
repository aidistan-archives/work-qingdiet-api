class CreateAcquirements < ActiveRecord::Migration[5.0]
  def change
    create_table :acquirements do |t|
      t.references :user, foreign_key: true
      t.references :combo, foreign_key: true, index: { unique: true }
      t.references :requirement, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
