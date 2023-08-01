class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path, notice: "Comment was successfully destroyed.")
  end


  private

  def comment_params
      params.require(:comment).permit(:content, :book_id)
  end
  def set_book
    @book = Book.find(params[:book_id])
  end
end