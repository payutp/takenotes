class Folder < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user, :foreign_key => :user_id
  has_many :notes, :dependent => :destroy

  # create a note
  def create_note(text, x, y, width, height)
  	return self.notes.create(:text => text, :x => x, :y => y, :width => width, :height => height)
  end
end
