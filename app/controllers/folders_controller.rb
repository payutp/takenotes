class FoldersController < ApplicationController

	before_filter :require_ownership

	def index
		@folders = current_user.folders.all
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @folders }
		end
	end

	def show
		@folder = current_user.folders.find(params[:id])
		@notes = @folder.notes.all
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @notes }
		end
	end
end
