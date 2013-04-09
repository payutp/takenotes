class NotesController < ApplicationController
	before_filter :require_ownership
end
