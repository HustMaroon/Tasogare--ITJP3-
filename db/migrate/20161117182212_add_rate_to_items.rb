class AddRateToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :rate, :float
  end
end
