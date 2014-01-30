class Customer < ActiveRecord::Base
  belongs_to :user
  attr_accessible :customer_id,:subscription_id,:plan_id
end
