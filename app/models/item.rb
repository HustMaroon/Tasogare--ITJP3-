class Item < ApplicationRecord
	belongs_to :user
	scope :approved_items, -> { where(approved: true) }
end
 