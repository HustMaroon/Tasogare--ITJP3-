class Item < ApplicationRecord
	belongs_to :user
	has_many :ratings, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :notifications
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

	def self.lookup(att, param)
		param.empty? ? Item.all : where("#{att} LIKE ?", param)
	end

	def self.filter(params)
		Item.lookup("name", params[:name])  & Item.lookup("brand", params[:brand]) & Item.lookup("model", params[:model]) &
		Item.lookup("RAM", params[:RAM]) & Item.lookup("VGA", params[:VGA]) &
		Item.lookup("HDD", params[:HDD]) & Item.lookup("price", params[:price]) & Item.lookup("screen", params[:screen]) &
		Item.lookup("OS", params[:OS]) & Item.lookup("PIN", params[:PIN])
	end

end
 