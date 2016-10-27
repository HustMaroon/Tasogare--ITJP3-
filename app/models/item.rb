class Item < ApplicationRecord
	belongs_to :user
	has_many :ratings, dependent: :destroy
	has_many :comments, dependent: :destroy
	mount_uploader :image, ItemImageUploader
	scope :approved_items, -> { where(approved: true) }

	def rating(rate_index)
		rater = self.rater
		rate = (self.rate * self.rater + rate_index)/(rater +1)
		rater += 1
		self.update_attributes(rate: rate, rater: rater)
	end
end
 