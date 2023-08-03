class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home, :about, :new, :create]
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  def edit
     ensure_correct_user
     @user = User.find(params[:id])
  end

  def update
     ensure_correct_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def follow
    user = User.find(params[:user_id])
    if current_user.follow(user)
      redirect_to user_path(user), notice: "You followed #{user.name}."
    else
      redirect_to user_path(user), alert: "Failed to follow #{user.name}."
    end
  end

  def unfollow
    user = User.find(params[:user_id])
    if current_user.unfollow(user)
      redirect_to user_path(user), notice: "You unfollowed #{user.name}."
    else
      redirect_to user_path(user), alert: "Failed to unfollow #{user.name}."
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
