class AddColumnToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :plan_id, :string
  end
end
