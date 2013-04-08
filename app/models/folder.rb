class Folder < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user, :foreign_key => :user_id
  has_many :notes
end
