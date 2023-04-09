class TopicsController < ApplicationController

  def new
    @topic = Topic.new
  end

  def create
    # 投稿データを@topicに格納
    @topic = Topic.new(topic_params)
    # 投稿データにログイン中のユーザーのidをもたせる
    @topic.user_id = current_user.id
    @topic.save
    redirect_to topic_path(@topic)
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
    topic.update(topic_params)
    redirect_to topic_path(topic.id)
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:image,:title)
  end
end
