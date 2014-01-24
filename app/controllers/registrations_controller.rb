class RegistrationsController < Devise::RegistrationsController
  before_filter :check_plan,:only=>[:new,:create]
  before_filter :create_card,:only=>[:create]
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
    # cardDetail={:number=>}
    result = Braintree::Subscription.create(
      :credit_card => {
      :number => "5105105105105100",
      :expiration_date => "05/2012"
      },
      :plan_id => "#{@plan.plan_key}"
    )

    if result.success?
      puts result.subscription.id
      puts result.subscription.transactions[0].id

    else
      result
    end


    #  flash[:alert]="This page is still under process"
    #  redirect_to(:back)
  	attributeUserProfile = params[:user][:userprofile]
  	params[:user]=params[:user].except(:userprofile,:card_name,:cvv,:exp_date)
  	@title="Sign up"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    super
    attributeUserProfile[:user_id]=@user.id
    @userProfile=Userprofile.create!(attributeUserProfile) rescue "" 
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
  def create_card
    debugger
    if params[:user].present?
      result = Braintree::CreditCard.create(
        :cardholder_name => "#{params[:user][:userprofile_attributes][:first_name]} #{params[:user][:userprofile_attributes][:last_name]}",
        :number => "#{params[:card_name]}",
        :cvv => "#{params[:cvv]}",
        :expiration_date => "#{params[:exp_date]}",
        :options => {
          :verify_card => true
        }
      )
      if result.success?


      else
        respond_to do |format|
          format.html{redirect_to :back,:flash=>{:notice=>""}}
        end
      end
    else
      flash[:alert]="Something went wrong"
      redirect_to :back
    end
  end
  # create customer ends here
  def update_customer
    result = Braintree::Customer.update("the_customer_id",
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