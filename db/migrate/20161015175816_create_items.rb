class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :cd
      t.string :RAM
      t.string :VGA
      t.string :HDD
      t.integer :price
      t.string :brand
      t.string :screen
      t.string :OS
      t.string :model
      t.string :PIN
      t.string :detail
      t.boolean :approved, default: false
      t.references :user

      t.timestamps
    end
  end
end
