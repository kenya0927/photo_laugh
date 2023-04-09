class TopicsController < ApplicationController

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @topic.save
    redirect_to topics_path
  end

  def index
    @topics = Topic.all
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def topic_params
    params.require(:topic).permit(:image,:title)
  end
end
