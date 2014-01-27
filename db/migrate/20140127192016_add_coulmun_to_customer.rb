class AddCoulmunToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :subscription_id, :string
  end
end
