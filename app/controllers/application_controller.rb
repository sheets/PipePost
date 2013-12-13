class ApplicationController < ActionController::Base
  protect_from_forgery
  layout Proc.new { |controller| controller.devise_controller? ? 'login' : 'application' }


  # path for redirection after user sign_in, depending on user role
	def after_sign_in_path_for(user)
	  (user.has_role? :admin)? '/admin/' : root_path 
	end
	rescue_from CanCan::AccessDenied do |exception|
	  respond_to do |format|
	    format.json do
	      render :json => { :success => false, :message => "You do not have access to do this action." }
	    end
	    format.html do
	      flash[:error] = 'You do not have access to view this page.'
	      redirect_to '/'
	    end
	  end	
	end
	
end
