class RegistrationsController < Devise::RegistrationsController
  before_filter :check_plan,:only=>[:new,:create]
  def new
  	@title="Sign up"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    @user=User.new
    @user.build_userprofile
  end

  def create
    flash[:alert]="This page is still under process"
    redirect_to(:back)
  	# attributeUserProfile = params[:user][:userprofile]
  	# params[:user]=params[:user].except(:userprofile)
  	# @title="Sign up"
    #  @breadcrumb=@title
    #  @description="Lorem ipsum dolor sit amet"
    #  super
    #  attributeUserProfile[:user_id]=@user.id
    #  @userProfile=Userprofile.create!(attributeUserProfile) rescue "" 
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
end 