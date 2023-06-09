class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update, :edit]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)   # 投稿データを@topicに格納
    @topic.user_id = current_user.id   # 投稿データにログイン中のユーザーのidをもたせる
    if @topic.save
      flash[:notice] = "投稿に成功しました"
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def index
    @topics = Topic.page(params[:page])
  end

  def show
    @topic = Topic.find(params[:id])
    @user = @topic.user
    @topic_comment = TopicComment.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:notice] = "更新に成功しました"
      redirect_to topic_path(@topic)
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  # キーワード検索
  def search
    search_word = params[:word]
    @topics = Topic.where("title LIKE ?", "%#{search_word}%")
  end


  private
    def topic_params
      params.require(:topic).permit(:image, :title)
    end

    def ensure_correct_user
      @topic = Topic.find(params[:id])
        if @topic.user != current_user
        flash[:alert] = "他人の投稿は編集できません"
        redirect_to root_path
        end
    end
end
