class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    current_user.favorite_books << @book
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorite_books.delete(@book)
    redirect_back(fallback_location: root_path)
  end
end