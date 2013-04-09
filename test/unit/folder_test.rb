require 'test_helper'

class FolderTest < ActiveSupport::TestCase

  test "create note" do
  	default = folders(:one)
  	note = default.create_note("x", 1, 2, 3, 4)

  	# check that note is added to folder default
  	assert default.notes.all.length == 1
  	assert note.text == "x"
  	assert note.x == 1
  	assert note.y == 2
  	assert note.width == 3
  	assert note.height == 4

  	note2 = default.create_note("y", 11, 22, 33, 44)
  	assert default.notes.all.length == 2
  	assert note2.text == "y"
  	assert note2.x == 11
  	assert note2.y == 22
  	assert note2.width == 33
  	assert note2.height == 44
  end
end
