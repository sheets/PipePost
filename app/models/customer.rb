class Customer < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription,:class_name=>"Customer"
  attr_accessible :customer_id,:subscription_id
end
