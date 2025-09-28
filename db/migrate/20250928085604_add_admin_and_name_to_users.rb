class AddAdminAndNameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :name, :string, null: false
  end
end
