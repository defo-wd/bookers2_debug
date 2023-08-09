class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.user_id = current_user.id
    unless @comment.save

    end
  end


  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])
    @comment.destroy

  end

  private
    def book_comment_params
    params.require(:comment).permit(:content)
    end
end