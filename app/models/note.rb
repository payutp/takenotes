class Note < ActiveRecord::Base
  attr_accessible :text
  belongs_to :folder, :foreign_key => :folder_id
end
