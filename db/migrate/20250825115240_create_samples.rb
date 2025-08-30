class CreateSamples < ActiveRecord::Migration[7.2]
  def change
    create_table :samples do |t|
      t.references :plant, null: false
      t.date :sampling_date, null: false
      t.time :sampling_time, null: false
      t.string :location
      t.string :inspector
      t.text :remarks
      t.timestamps
    end
  end
end
