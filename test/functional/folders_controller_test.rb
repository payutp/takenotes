require 'test_helper'

class FoldersControllerTest < ActionController::TestCase

	def json_response
		ActiveSupport::JSON.decode @response.body
	end

	setup do
		@a = users(:one)
		session[:user_id] = @a.id

		@a.create_default_folder
		@folder = @a.folders.all[0]
		@note = @folder.create_note("x", 1, 2, 3, 4)
	end

	test "should get index" do
		get :index
		assert_response :success
		assert_not_nil assigns(:folders)
	end

	test "should get notes" do
		get :get_notes, :id => @folder
		assert_response :success
	end

	test "should create note" do
		post :create_note, :format => :json, :id => @folder, :text => "y", :x => 11, :y => 22, :width => 33, :height => 44
		respond = JSON.parse(@response.body)
		assert_equal("y", respond["text"])
		assert_equal(11, respond["x"])
		assert_equal(22, respond["y"])
		assert_equal(33, respond["width"])
		assert_equal(44, respond["height"])
		assert_response :success
	end

	test "should edit note" do
		post :edit_note, :id => @folder, :note_id => @note, :text => "xx", :x => 11, :y => 22, :width => 33, :height => 44
		assert_response :success
	end

	test "should delete note" do
		post :delete_note, :id => @folder, :note_id => @note
		assert_response :success
	end

	test "should create folder and not allow dupliated folder" do
		post :create, :format => :json, :name => "todo"
		assert_equal(2, @a.folders.count) 

		post :create, :format => :json, :name => "x"
		assert_equal(3, @a.folders.count) 

		post :create, :format => :json, :name => "todo"
		assert_equal(3, @a.folders.count) 
	end

	test "delete folder" do
		post :create, :format => :json, :name => "todo"
		assert_equal(2, @a.folders.count)
		respond = JSON.parse(@response.body)

		post :delete, :format => :json, :id => respond["id"]
		assert_equal(1, @a.folders.count) 
	end

	test "get other folders" do
		id = @a.folders.all[0].id
		post :get_other_folders, :format => :json, :id => id
		respond = JSON.parse(@response.body)
		assert_equal(0, respond.length)

		post :create, :format => :json, :name => "todo"

		post :get_other_folders, :format => :json, :id => id
		respond = JSON.parse(@response.body)
		assert_equal(1, respond.length)
	end

	test "move folder" do
		id = @a.folders.all[0].id
		post :create, :format => :json, :name => "todo"
		respond = JSON.parse(@response.body)
		id2 = respond["id"]

		f1 = @a.folders.all[0]
		f2 = @a.folders.all[1]

		post :create_note, :format => :json, :id => f1, :text => "y", :x => 11, :y => 22, :width => 33, :height => 44
		respond = JSON.parse(@response.body)
		id3 = respond["id"]
		assert_equal(2, f1.notes.count)
		assert_equal(0, f2.notes.count)

		post :move_folder, :id => f1, :new_folder_id => id2, :note_id => id3
		assert_equal(1, f1.notes.count)
		assert_equal(1, f2.notes.count)
	end
end
