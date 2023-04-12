class TopicsController < ApplicationController

  before_action :authenticate_user!,only:[:edit,:update,:destroy]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)   #投稿データを@topicに格納
    @topic.user_id = current_user.id   #投稿データにログイン中のユーザーのidをもたせる
    if @topic.save
       flash[:notice] = "投稿に成功しました"
    redirect_to topic_path(@topic)
    else
      flash[:alert] = "投稿に失敗しました"
    render :new
    end
  end

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    topic = Topic.find(params[:id])
    if topic.update(topic_params)
       flash[:notice] = "更新に成功しました"
    redirect_to topic_path(topic.id)
    else
       flash[:alert] = "更新に失敗しました"
    render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  def search
    search_word = params[:word]
    @topics = Topic.where("title LIKE ?","%#{search_word}%")
  end

  private

  def topic_params
    params.require(:topic).permit(:image,:title)
  end
end
