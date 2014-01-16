class RegistrationsController < Devise::RegistrationsController
  before_filter :check_plan,:only=>[:new,:create]
  before_filter :create_customer,:only=>[:create]
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
    debugger
    
    result = Braintree::Subscription.create(:credit_card => cardDetail,:plan_id => "#{@plan.plan_key}")

    if result.success?
      puts result.subscription.id
      puts result.subscription.transactions[0].id
      attributeUserProfile = params[:user][:userprofile]
      params[:user]=params[:user].except(:userprofile,:card_name,:cvv,:exp_date)
      @title="Sign up"
      @breadcrumb=@title
      @description="Lorem ipsum dolor sit amet"
      super
      attributeUserProfile[:user_id]=@user.id
      @userProfile=Userprofile.create!(attributeUserProfile) rescue "" 
    else
      result
      redirect_to(:back)
    end


    #  flash[:alert]="This page is still under process"
  end

  def update
    super
  end
  # private methods
  private
  def check_plan
    findPlan=Plan.find_by_name(params[:plan])
    if findPlan.blank?
      redirect_to static_pages_pricing_table_path
      flash[:notice]="Please select plan to signup"
    else
      @plan = findPlan
    end
  end
  def create_customer
    cardDetail={:number=>params[:user][:card_name],:expiration_date=>params[:user][:expiration_date],:cvv=>params[:user][:cvv]}
    result = Braintree::Customer.create(:first_name =>params[:user][:first_name],:last_name => params[:user][:last_name],:credit_card =>cardDetail)
    unless result.success?
      flash[:alert]="Error: #{result.message}"
      redirect_to(:back)
    end
  end
end 