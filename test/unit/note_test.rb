require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  test "update note" do
  	note_a = notes(:one)
  	note_b = notes(:two)

  	note_a.update_value("xx", 1, 2, 3, 4)

  	# check that note_a has the updated values
  	assert note_a.text == "xx"
  	assert note_a.x == 1
  	assert note_a.y == 2
  	assert note_a.width == 3
  	assert note_a.height == 4

  	note_b.update_value(1, 2, 3, 4, 5)
  	assert note_b.text == 1
  end
end
