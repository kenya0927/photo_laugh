class LikesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @topic_comment = TopicComment.find(params[:topic_comment_id])
    like = current_user.likes.new(topic_id: @topic.id, topic_comment_id: @topic_comment.id)
    like.save
    render :button
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @topic_comment = TopicComment.find(params[:topic_comment_id])
    like = current_user.likes.find_by(topic_id: @topic.id, topic_comment_id: @topic_comment.id)
    like.destroy
    render :button
  end
end
