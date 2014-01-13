class Userprofile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :age, :city, :company_name, :country, :first_name, :last_name, :mailing_address, :phone, :state, :zip,:user_id
  validates :last_name,:first_name,:address,:age,:city,:country,:presence=>true
end
