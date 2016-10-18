class AdminController < ApplicationController
	include ApplicationHelper
	before_action :admin_user

	def items_index
		@items = Item.all
	end

	def users_index
		@users = User.all
	end

	def approve_item
		byebug
		item = Items.find(params[:id])
		item.update_attributes(approved: true)
		respond_to do |format|
			format.html{redirect_to :back}
			format.js
		end
	end

	def unapprove_item
		item = Items.find(params[:id])
		item.update_attributes(approved: false)
		respond_to do |format|
			format.html{redirect_to :back}
			format.js
		end
	end
end
