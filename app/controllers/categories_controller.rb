class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    return redirect_to root_path unless @category

    @pagy, @books = pagy @category.books.top_score
  end
end
