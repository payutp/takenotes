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

	# create a new folder
	def create
		if current_user.folders.exists?(:name => params[:name])
			ret = { :status => "duplicated" }
		else 
			ret = current_user.folders.create(:name => params[:name])
		end

		respond_to do |format|
			format.json {render :json => ret }
			format.all {render :text => "Only JSON supported at the moment"}
		end
	end

	# delete a folder, except default folder
	def delete
		folder = current_user.folders.find(params[:id])
		name = folder.name
		if folder.name == "Default"
			ret = { :status => "default" }
		else
			folder.destroy
			ret = { :status => "success", :name => name }
		end

		respond_to do |format|
			format.json {render :json => ret }
			format.all {render :text => "Only JSON supported at the moment"}
		end	
	end

	# get all folders that don't have id equal to specified id
	def get_other_folders
		folders = current_user.folders.where(["id != ?", params[:id]])

		respond_to do |format|
			format.json {render :json => folders}
			format.all {render :text => "Only JSON supported at the moment"}
		end
	end

	# move a note from one folder to another
	def move_folder
		folder = current_user.folders.find(params[:id])
		new_folder = current_user.folders.find(params[:new_folder_id])
		note = folder.notes.find(params[:note_id])
		#att = note.attributes
		#new_folder.notes.create_note(att)
		#note.destroy
		new_folder.notes << note


		respond_to do |format|
			format.json { render :json => {:status => "success"}}
			format.all {render :text => "Only JSON supported at the moment"}
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
