class TransactionsController < ApplicationController
	layout 'static_pages'
	require "rubygems"
	require "braintree"

	Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = "t99rmv6yyz6k2xvm"
	Braintree::Configuration.public_key = "x6h7w7tyqt7nm9f8"
	Braintree::Configuration.private_key = "23c60ed7187c772802307c1f2d06d8bd"
	def new
		
	end

	def create_customer
		result = Braintree::Transaction.sale(params[:braintree])
		if result.success?
			respond_to do |format|
				format.html{redirect_to transactions_new_path,flash[:success]=>"dfdfgdfgdfg"}
			end
		else
			respond_to do |format|
				format.html{redirect_to transactions_new_path,:flash => { :alert => "#{result.errors.map{|d| d.message}}" }  }
			end
		end
	end	

end
