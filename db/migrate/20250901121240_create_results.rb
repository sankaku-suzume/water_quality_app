class CreateResults < ActiveRecord::Migration[7.2]
  def change
    create_table :results do |t|
      t.references :sample, null: false
      t.references :test_item, null: false
      t.float :value
      t.timestamps
    end
  end
end
