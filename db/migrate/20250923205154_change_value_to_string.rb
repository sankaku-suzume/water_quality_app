class ChangeValueToString < ActiveRecord::Migration[7.2]
  def up
    change_column :results, :value, :string
  end

  def down
    change_column :results, :value, :float
  end
end
