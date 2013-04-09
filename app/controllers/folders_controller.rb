class FoldersController < ApplicationController

	before_filter :require_ownership

	# show all folders
	def index
		@folders = current_user.folders.all
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @folders }
		end
	end

	# show notes for a folder
	def show
		@folder = current_user.folders.find(params[:id])
		@notes = @folder.notes.all
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @notes }
		end
	end

	# return a json object for all notes
	def get_notes
		folder = current_user.folders.find(params[:id])
		notes = folder.notes.all

		respond_to do |format|
			format.json {render :json => notes }
			format.all {render :text => "Only JSON supported at the moment"}
		end
	end

	# create a note in the database
	# return a json object fot that note
	def create_note
		folder = current_user.folders.find(params[:id])
		note = folder.create_note(params[:text], params[:x], params[:y], params[:width], params[:height])

		respond_to do |format|
			format.json {render :json => note }
                        format.all {render :text => "Only JSON supported at the moment"}
		end
	end

	# edit a note in the database
	# return a json object fot that note
	def edit_note
		folder = current_user.folders.find(params[:id])
		note = folder.notes.find(params[:note_id])
		note = note.update_value(params[:text], params[:x], params[:y], params[:width], params[:height])

		respond_to do |format|
			format.json {render :json => note }
                        format.all {render :text => "Only JSON supported at the moment"}
		end
	end

	# delete a note in the database
	def delete_note
		folder = current_user.folders.find(params[:id])
		note = folder.notes.find_by_id(params[:note_id])
		note.destroy

		respond_to do |format|
			format.json {render :json => nil }
                        format.all {render :text => "Only JSON supported at the moment"}
		end
	end
end
