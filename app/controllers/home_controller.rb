class HomeController < ApplicationController
  def index
    @top_ratings = Item.get_top_ratings(8)
    @top_newest = Item.get_top_newest(8)
    @slide_items = Item.get_slide_items(3)
  end
end
