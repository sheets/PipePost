class RegistrationsController < Devise::RegistrationsController
  def new
  	@title="Sign up"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    @user=User.new
  end

  def create
  	attributeUserProfile = params[:user][:user_profiles]
  	params[:user]=params[:user].except(:user_profiles)
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
end 