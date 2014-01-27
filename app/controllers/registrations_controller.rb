class RegistrationsController < Devise::RegistrationsController
	before_filter :check_plan,:only=>[:new,:create]
	before_filter :create_customer,:only=>[:create]
	before_filter :create_customer_subscription,:only=>[:create]
	after_filter :create_customer_entry,:only=>[:create]
	require "rubygems"
	require "braintree"

	Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = "t99rmv6yyz6k2xvm"
	Braintree::Configuration.public_key = "x6h7w7tyqt7nm9f8"
	Braintree::Configuration.private_key = "23c60ed7187c772802307c1f2d06d8bd"
	def new
		@title="Sign up"
		@breadcrumb=@title
		@description="Lorem ipsum dolor sit amet"
		@user=User.new
		@user.build_userprofile
	end

	def create
		attributeUserProfile=params[:user][:userprofile_attributes]
		params[:user]=params[:user].except(:userprofile_attributes,:card_name,:cvv,:exp_date)
		@title="Sign up"
		@breadcrumb=@title
		@description="Lorem ipsum dolor sit amet"
		super
		params[:user][:card_name]="XXX"
		params[:user][:cvv]="XXX"
		params[:user][:exp_date]="XXX"
		@user.build_userprofile(attributeUserProfile).save!
	end

	def update
		super
	end
	# private methods
	private
	# check customer plan
	def check_user_plan
		# exception handling
		begin
			@userPlan=current_user.plan
			if @userPlan.blank?

			else

			end
		rescue Exception=>e
			puts e.message
		end
		# exception handling
	end
	#check customer plans ends here
	def check_plan
		findPlan=Plan.find_by_name(params[:plan])
		if findPlan.blank?
			redirect_to static_pages_pricing_table_path
			flash[:notice]="Please select plan to signup"
		else
			@plan = findPlan
		end
	end
	# customer create starts from here
	def create_customer
		if params[:user].present?
			result = Braintree::Customer.create(
				:first_name => "#{params[:user][:userprofile_attributes][:first_name]}",
				:last_name => "#{params[:user][:userprofile_attributes][:last_name]}",
				:company => "#{params[:user][:userprofile_attributes][:company_name]}",
				:email => "#{params[:user][:email]}",
				:phone => "#{params[:user][:userprofile_attributes][:phone]}",
				:credit_card => {:cardholder_name=>"#{params[:user][:userprofile_attributes][:first_name]} #{params[:user][:userprofile_attributes][:last_name]}",:number => "#{params[:user][:card_name]}",:cvv => "#{params[:user][:cvv]}",:expiration_date =>"#{params[:user][:exp_date]}"
				# :options => {:verify_card => true}
				})
			if result.success?
				@customer_key=result.customer.id
				@card_token=result.customer.credit_cards.first.token
			else
				respond_to do |format|
					format.html{redirect_to :back,:flash=>{:alert=>"#{result.errors.map{|key| key}}"}}
				end
			end
		else
			flash[:alert]="Something went wrong"
			redirect_to :back
		end
	end
	# customer create ends here
	def create_customer_entry
		@user.build_customer(:customer_id=>@customer_key,:subscription_id=>@subscription_id).save!
	end
	def create_customer_subscription	

		result = Braintree::Subscription.create(
			:payment_method_token => "#{@card_token}",
			:plan_id => "#{@plan.plan_key}"
		)
		if result.success?
			@subscription_id=result.subscription.id	
		else
			respond_to do |format|
				format.html{redirect_to :back,:flash=>{:alert=>"#{result.errors.map{|d| d}}"}}
			end
		end
	end
	def update_customer
		customerId=current_user.customer.first.customer_id
		result = Braintree::Customer.update("customerId",
			:credit_card => {
			:cardholder_name => "Bob Smith",
			:number => "4111111111111111",
			:expiration_date => "05/2012",
			:options => {
				:verify_card => true
			}
		}) 
	end
	# update customer id ends here
end 