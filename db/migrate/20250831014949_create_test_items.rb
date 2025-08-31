class CreateTestItems < ActiveRecord::Migration[7.2]
  def change
    create_table :test_items do |t|
      t.string :name, null: false
      t.string :unit
      t.float :detection_limit
      t.float :standard_min
      t.float :standard_max
      t.timestamps
    end
  end
end
