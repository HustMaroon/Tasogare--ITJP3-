class ItemsController < ApplicationController
	include ApplicationHelper
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy, :rate]

	def index
		@items = current_user.items
	end

	def new
	end

	def create
		item = current_user.items.build(item_params)
		item.rate = params[:rate]
		if item.save
			redirect_to item
			flash.now[:success]= "review created"
		else
			flash.now[:warning] = "failed to create review"
			redirect_to request.referrer
		end
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		item = Item.find(params[:id])
		item.update_attributes(item_params)
		item.rate = params[:rate]
		item.save
		redirect_to item
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

	def rate
		@item = Item.find(params[:item])
		rating = Rating.find_by(user_id: current_user.id, item_id: @item.id)
		if rating.nil?
			@item.ratings.create!(user: current_user, rate: params[:rate])
		else
			rating.update_attributes(rate: params[:rate])
		end
		redirect_to @item
	end

	def search
		@items = Item.search(params[:search])
	end

	def filter
		@items = Item.filter(params)
	end

private
	def item_params
		params.require(:item).permit(:name, :cd, :RAM, :VGA, :HDD, :price, :brand, :screen, 
			                           :OS, :model, :PIN, :detail_review, :pros, :cons, :image)
	end
	def sum(ratings)
		sum = 0
		ratings.each do |rating|
			sum += rating.rate.nil? ? 0 : rating.rate
		end
		sum
	end
end
