class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.float :age
      t.float :height
      t.float :weight
      t.float :activity_level

      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
