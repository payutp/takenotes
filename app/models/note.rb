class Note < ActiveRecord::Base
  attr_accessible :height, :text, :width, :x, :y
  belongs_to :folder, :foreign_key => :folder_id

  # method for updating a note
  def update_value(text, x, y, width, height)
  	self.text = text
  	self.x = x
  	self.y = y
  	self.width = width
  	self.height = height
  	self.save
  	return self
  end
end
