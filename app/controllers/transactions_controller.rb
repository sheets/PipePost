class TransactionsController < ApplicationController
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
		challenge = request.params["bt_challenge"]
  	challenge_response = Braintree::WebhookNotification.verify(challenge)
  	return [200, challenge_response]
	end
	
	def subregion_options
  		render partial: 'subregion_select'
	end

end
