class AddSomeFieldsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :pros, :text
    add_column :items, :cons, :text
    add_column :items, :detail_review, :text
    add_column :items, :rate, :float
    add_column :items, :image, :string
  end
end
