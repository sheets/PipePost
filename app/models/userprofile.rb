class Userprofile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :age, :city, :company_name, :country, :first_name, :last_name, :mailing_address, :phone, :state, :zip,:user_id
  validates :first_name, presence: true
  validates :last_name, presence: true
end
