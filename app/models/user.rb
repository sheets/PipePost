class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:card_details
  has_one :userprofile,:dependent=>:destroy
  has_one :card,:dependent=>:destroy
  # validations
  accepts_nested_attributes_for :userprofile
  attr_reader :amount,:card_name,:cvv,:exp_date
  validates :card_name,:amount,:cvv,:exp_date,:presence => true
  validates_uniqueness_of :email
  # validates :address, :age, :city, :country, :first_name, :last_name, :mailing_address, :phone, :state, :zip, :presence => true
  def current_admin
  	current_user && current_user.has_role?(:admin)
	end
end
