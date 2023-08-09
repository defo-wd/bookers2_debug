class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:home, :about, :new, :create]
  before_action :set_book, only: [:show]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
    @comment = Comment.new
    @comments = Comment.all
  end

  def index
    @books = Book.all
    @book = Book.new

    if params[:search].present?
      @books = Book.search(params[:search])
    else
      @books = Book.all
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def is_matching_login_user
  book = Book.find(params[:id])
  unless book.user_id == current_user.id
    redirect_to books_path
  end
  end


  def book_params
    params.require(:book).permit(:title, :body)
  end


  def set_book
    @book = Book.find(params[:id])
  end


end
