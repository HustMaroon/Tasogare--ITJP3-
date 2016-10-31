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
		return Item.order('created_at DESC').limit(number)
	end

	def self.search(search)
	  if search
	    where("name LIKE ?", "%#{search}%")
	  else
	    Item.all
	  end
	end 

end
 