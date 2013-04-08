class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			@user.create_default_folder
			redirect_to folders_path, :notice => "You are signed up."
		else
			render "new"
		end
	end
end