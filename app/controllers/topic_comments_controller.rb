class TopicCommentsController < ApplicationController

  def create
    topic = Topic.find(params[:topic_id])
    # ログインしているユーザーによって作成されたコメントの生成
    comment = current_user.topic_comments.new(topic_comment_params)
    # コメントと投稿の関連付け
    comment.topic_id = topic.id
    comment.save
    redirect_to topic_path(topic)
  end

  def destroy
    TopicComment.find(params[:id]).destroy
    redirect_to topic_path(params[:topic_id])
  end

  private

  def topic_comment_params
    params.require(:topic_comment).permit(:comment)
  end

end
