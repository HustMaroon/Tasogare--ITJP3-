class Item < ApplicationRecord
	belongs_to :user
	has_many :ratings, dependent: :destroy
	has_many :comments, dependent: :destroy
	mount_uploader :image, ItemImageUploader
	scope :approved_items, -> { where(approved: true) }
  mount_uploader :image, AvatarUploader

	def rating(rate_index)
		rater = self.rater
		rate = (self.rate * self.rater + rate_index)/(rater +1)
		rater += 1
		self.update_attributes(rate: rate, rater: rater)
	end

	def self.get_top_newest(number)
		# Item.where(approved: true).order('created_at DESC').limit(number)
		Item.where(approved: true).order('created_at DESC').limit(number)
	end

	def self.get_slide_items(number)
		Item.where(approved: true).order("RANDOM()").limit(number)
	end

	def self.get_top_ratings(number)
		Item.where(approved: true).order('rate DESC').limit(number)
	end

	def self.search(search)
	  if search
	    where("name LIKE ?", "%#{search}%")
	  else
	    Item.all
	  end
	end

	def self.filter(params)
		if params[:price] and params[:RAM] and params[:VGA] and params[:HDD] and params[:model] and params[:brand] and params[:PIN]
			where("price < ? OR RAM LIKE ? OR VGA LIKE ? OR HDD LIKE ? OR model LIKE ? OR brand LIKE ? OR PIN LIKE ?",
						"#{params[:price]}", "%#{params[:RAM]}%", "%#{params[:VGA]}%", "%#{params[:HDD]}%", "%#{params[:model]}%", "%#{params[:brand]}%", "%#{params[:PIN]}%");
		else
			nil
		end
	end

end
 