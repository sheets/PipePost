class RenameTypeToProductType < ActiveRecord::Migration
  def up
  	rename_column :products, :type, :product_type
  end

  def down
  end
end
