class CreateRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :requirements do |t|
      t.string :purpose

      t.timestamps

      t.references :user, foreign_key: true
      t.references :measurement, foreign_key: true
    end
  end
end
