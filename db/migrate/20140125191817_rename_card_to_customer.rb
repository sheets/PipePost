class RenameCardToCustomer < ActiveRecord::Migration
  def up
  	rename_table :cards, :customers
  end

  def down
  	rename_table :cards, :customers
  end
end
