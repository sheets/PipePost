class TransactionsController < ApplicationController
	before_filter :authenticate_user! ,:except=>:subregion_options
	before_filter :build_subscription ,:only=>[:subscription_detail,:cancel_subscription]
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
		
		@subscription = Braintree::Subscription.find(@subscription_id)
		unless @subscription.blank?
			@title="Subscription detail"
		    @breadcrumb=@title
		    @description="Lorem ipsum dolor sit amet"
		    respond_to do |format|
		      format.json
		      format.html{@subscription}
		    end
		else
			flash[:alert]="result.errors.map{|d| d.message}.to_sentence"
			redirect_to :back
		end
	end
	# cancel subscription
	def cancel_subscription
		result = Braintree::Subscription.cancel(@subscription_id)
		if result.success?
			if current_user.customer.update_attribute(:subscription,false)
				flash[:notice]="Subscription successfully Canceled"
				UserMailer.welcome_email("user").deliver
				redirect_to static_pages_home_path
			else
				flash[:alert]="Something went wrong"
				redirect_to :back
			end	
		else
			flash[:alert]="#{result.errors.map{|d| d.message}.to_sentence}"
			redirect_to :back
		end		
	end
	# plan list
	def plan_list
		if current_user.customer.subscription
			user_plan_id=[current_user.plan.plan_id]
			@plan_list=Plan.find(:all,:condition=>['id not in (?)',user_plan_id])
		else
			@plan_list=Plan.all
		end
	end
	private
	
	def build_subscription
		begin
			@subscription_id=current_user.customer.subscription_id
		rescue Exception => e
			puts e.message
		end
	end
end
