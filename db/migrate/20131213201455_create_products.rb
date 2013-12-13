class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.float :price
      t.text :description
      t.text :image

      t.timestamps
    end
  end
end
