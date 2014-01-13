class RegistrationsController < Devise::RegistrationsController
  def new
  	@title="Sign up"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    @user=User.new
    @user.build_userprofile
  end

  def create
  	attributeUserProfile = params[:user][:userprofile]
  	params[:user]=params[:user].except(:userprofile)
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