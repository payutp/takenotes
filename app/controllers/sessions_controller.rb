class SessionsController < ApplicationController
	def new
	end

	def show
	end

	def create
		user = User.find_by_email(params[:email])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to folders_path, :notice => "Logged in"
		else
			redirect_to login_path, :notice => "Invalid e-mail or password"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url :notice => "Logged out"
	end
end
