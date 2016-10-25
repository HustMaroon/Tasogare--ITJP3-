class Item < ApplicationRecord
	belongs_to :user
	has_many :ratings, dependent: :destroy
	scope :approved_items, -> { where(approved: true) }

	def rating(rate_index)
		rater = self.rater
		rate = (self.rate * self.rater + rate_index)/(rater +1)
		rater += 1
		self.update_attributes(rate: rate, rater: rater)
	end
end
 