class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # ユーザーの投稿を全て取得
    @topics = @user.topics
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params
    )
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

end
