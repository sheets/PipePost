class TransactionsController < ApplicationController
	before_filter :authenticate_user! ,:except=>:subregion_options
	layout 'static_pages'
	require "rubygems"
	require "braintree"

	Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = "t99rmv6yyz6k2xvm"
	Braintree::Configuration.public_key = "x6h7w7tyqt7nm9f8"
	Braintree::Configuration.private_key = "23c60ed7187c772802307c1f2d06d8bd"
	def all_plan
		plans = Braintree::Plan.all	
	end

	def create
	end	

	def offline_notification
		UserMailer.welcome_email("user").deliver
	end
	
	def subregion_options
  		render partial: 'subregion_select'
	end

	def subscription_detail
		begin
			subscription_id=current_user.customer.subscription_id
		rescue Exception => e
			puts e.message
		end
		
		subscription = Braintree::Subscription.find(subscription_id)
		
		unless subscription.blank?
			respond_to do |format|
				format.html{@subscription=subscription}
			end
		else
			flash[:alert]="result.errors.map{|d| d}"
			redirect_to :back
		end
	end

end
