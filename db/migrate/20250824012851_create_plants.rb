class CreatePlants < ActiveRecord::Migration[7.2]
  def change
    create_table :plants do |t|
      t.timestamps
      t.string :name, null: false
      t.string :location
      t.text :remarks
    end
  end
end
