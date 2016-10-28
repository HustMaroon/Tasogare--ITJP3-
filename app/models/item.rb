class Item < ApplicationRecord
	belongs_to :user
	has_many :ratings, dependent: :destroy
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
end
 