class HomeController < ApplicationController
  def index
    @top_ratings = Rating.get_top_rating(8)
    @top_newest = Item.get_top_newest(8)
  end
end
