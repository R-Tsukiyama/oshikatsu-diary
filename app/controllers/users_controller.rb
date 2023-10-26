class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update, :show]

  def mypage
    @user = current_user
  end
  
  def show
    @user = current_user
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to user_path(current_user)
    else
      render "edit"
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
