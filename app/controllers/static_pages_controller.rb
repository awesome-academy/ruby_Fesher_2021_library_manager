class StaticPagesController < ApplicationController
  before_action :load_books

  def home
    @pagy, @books = pagy @q.result(distinct: true),
                         items: Settings.length.home_items
  end
end
