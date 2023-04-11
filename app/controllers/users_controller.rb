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
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  # ユーザーがいいねした記事の取得
  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:topic_id)
    @like_topics = Topic.find(likes)
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

end
