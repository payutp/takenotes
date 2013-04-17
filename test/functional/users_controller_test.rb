require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	setup do
		@user = users(:one)
		@user2 = users(:two)
	end

	test "should create user" do
		post :create, :format => :json, :user => { email: "x@mit.edu", password: "x", password_confirmation: "x"}
		assert_equal(3, User.count)
	end

	test "email in use" do
		post :create, :format => :json, :user => { email: 'a', password: "x", password_confirmation: "x"}
		assert_equal(2, User.count)
	end
end
