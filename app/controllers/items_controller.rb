class ItemsController < ApplicationController
	include ApplicationHelper
	before_action :logged_in_user, onlly: [:create]

	def index
		@items = Item.approved_items + current_user.items
	end

	def new
	end

	def create
		item = current_user.items.build(item_params)
		if item.save
			redirect_to item
			flash.now[:success]= "review created"
		else
			flash.now[:warning] = "failed to create review"
			redirect_to request.referrer
		end
	end

	def edit
	end

	def show
		@item = Item.find(params[:id])
	end

	def destroy
		item = Item.find(params[:id])
		@id = item.id
		item.destroy
		respond_to do |format|
			format.html{ redirect_to :back}
			format.js
		end
	end

private
	def item_params
		params.require(:item).permit(:name, :cd, :RAM, :VGA, :HDD, :price, :brand, :screen, :OS, :model, :PIN, :details)
	end
end
