class AdminsController < ApplicationController
	include ApplicationHelper
	before_action :admin_user

	def items_index
		@items = Item.all
	end

	def users_index
		@users = User.all
	end

	def approve_item
		@item = Item.find(params[:item][:id])
		@item.update_attributes(approved: true)
		respond_to do |format|
			format.html{redirect_to :back}
			format.js
		end
	end

	def unapprove_item
		@item = Item.find(params[:item][:id])
		@item.update_attributes(approved: false)
		respond_to do |format|
			format.html{redirect_to :back}
			format.js
		end
	end
end
