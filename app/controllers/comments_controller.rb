class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
    end
    redirect_to @book
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to @comment.book
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :book_id)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
