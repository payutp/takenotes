class Note < ActiveRecord::Base
  attr_accessible :height, :text, :width, :x, :y
  belongs_to :folder, :foreign_key => :folder_id
end
