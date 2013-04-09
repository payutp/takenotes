require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "create default folder" do
  	a = users(:one)
  	b = users(:two)

  	a.create_default_folder()

  	# test that a folder is created for a
  	assert (a.folders.all != nil), "a should have a default folder"
  	assert (a.folders.all[0].name == "Default")
  	assert (b.folders.all.length == 0), "b has no folder"
  end
end
