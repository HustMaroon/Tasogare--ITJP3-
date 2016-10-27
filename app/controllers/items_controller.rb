class ItemsController < ApplicationController
	include ApplicationHelper
	before_action :logged_in_user, onlly: [:create]

	def index
		@items = Item.approved_items + current_user.items
	end

	def new
	end

	def update
    # authorize! :update, @item
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Your review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

	def create
		item = current_user.items.build(item_params)
		if item.save
			item.ratings.create!(rate: params[:rate], user: current_user)
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

	def show
		@item = Item.find(params[:id])
		@ratings = @item.ratings.count
		@rate_point = sum(@item.ratings)/@ratings
		rating = Rating.find_by(user: current_user, item: @item)
		@rated_value = rating.nil? ? 0 : rating.rate 
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

private
	def item_params
		params.require(:item).permit(:name, :cd, :RAM, :VGA, :HDD, :price, :brand, :screen, :OS, :model, :PIN, :detail_review)
	end
	def sum(ratings)
		sum = 0
		ratings.each do |rating|
			sum+= rating.rate 
		end
		sum
	end
end
