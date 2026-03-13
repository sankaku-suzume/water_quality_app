class CreateApprovals < ActiveRecord::Migration[7.2]
  def change
    create_table :approvals do |t|
      t.references :result, null: false
      t.integer :action
      t.string :user_name
      t.string :comment
      t.timestamps
    end
  end
end
