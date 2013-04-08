class NotesController < ApplicationController
	before_ownership :require_ownership
end
