class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:user_profiles
  has_one :userprofile,:dependent=>:destroy
  # attr_accessible :title, :body 
  # validations
  accepts_nested_attributes_for :userprofile
  validates :password, :email, :presence => true
  def current_admin
  	current_user && current_user.has_role?(:admin)
	end
end
