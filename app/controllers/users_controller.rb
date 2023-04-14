class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @topics = @user.topics.page(params[:page])   #ユーザーの投稿を全て取得
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
        flash[:notice] = "更新に成功しました"
      redirect_to user_path(@user)
     else
      render :edit
     end
  end

  # ユーザーがいいねした記事の取得
  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id,topic_comment_id: @topic_comment).pluck(:topic_id,:topic_comment_id)
    @like_topics = Topic.find(likes)
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

  # ゲストユーザーのユーザー編集画面へのURL直打ちを防ぐ
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
       flash[:notice] ="ゲストユーザーはプロフィール編集画面へ遷移できません。"
       redirect_to root_path
    end
  end

end
