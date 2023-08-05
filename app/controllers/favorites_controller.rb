class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    current_user.favorite_books << @book
  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorite_books.delete(@book)
  end
end