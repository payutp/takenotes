class ApplicationController < ActionController::Base
  protect_from_forgery

  private 
  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  helper_method :current_user

 	# Check if the user is logged in. If not, redirect the user to the log in page.
	def require_ownership
		unless current_user
			redirect_to login_path
		end
	end
end
