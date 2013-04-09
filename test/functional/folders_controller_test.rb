require 'test_helper'

class FoldersControllerTest < ActionController::TestCase

	def json_response
		ActiveSupport::JSON.decode @response.body
	end

	setup do
		a = users(:one)
		session[:user_id] = a.id

		a.create_default_folder
		@folder = a.folders.all[0]
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
		post :create_note, :id => @folder, :text => "y", :x => 11, :y => 22, :width => 33, :height => 44
		assert_response :success
	end

	test "should edit note" do
		post :edit_note, :id => @folder, :note_id => @note, :text => "xx", :x => 11, :y => 22, :width => 33, :height => 44
		assert_response :success
	end
end
