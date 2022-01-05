class StaticPagesController < ApplicationController
  def home
    @pagy, @books = pagy(Book.top_score, items: Settings.length.home_items)
  end
end
