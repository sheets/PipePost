class AddColumnSubscriptionToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :subscription, :boolean,:default => false
  end
end
