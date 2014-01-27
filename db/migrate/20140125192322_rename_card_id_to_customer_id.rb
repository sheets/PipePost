class RenameCardIdToCustomerId < ActiveRecord::Migration
  def up
  	rename_column :customers, :card_id, :customer_id
  end

  def down
  	rename_column :customers, :card_id, :customer_id
  end
end
