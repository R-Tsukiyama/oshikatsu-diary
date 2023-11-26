class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update, :show]

  def mypage
    @user = current_user
  end
  
  def show
    @user = current_user
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = current_user
    if user_params[:username].present? && @user.update(user_params)
      redirect_to posts_index_path, notice: '更新しました。'
    else
      flash.now[:alert] = '名前を入力してください。' if user_params[:username].blank?
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(
      :username,
      :profile,
      :userimage,
      :user_id
    )
  end
end
