class LikesController < ApplicationController

  def create
    topic = Topic.find(params[:topic_id])
    comment = TopicComment.find(params[:topic_comment_id])
    like = Like.create(user_id: current_user.id, topic_id: topic.id, topic_comment_id: topic_comment.id)
    like.save
    redirect_to topic_path(topic)
  end

  def destroy
    topic = Topic.find(params[:topic_id])
    comment = TopicComment.find(params[:topic_comment_id])
    Like.find_by(user_id: current_user.id, topic_id: topic.id, topic_comment_id: topic_comment.id).destroy
    redirect_to topic_path(topic)
  end

end
