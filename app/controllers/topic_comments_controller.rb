class TopicCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @topic = Topic.find(params[:topic_id])
    @topic_comment = TopicComment.new
    comment = current_user.topic_comments.new(topic_comment_params)   #ログインしているユーザーによって作成されたコメントの生成
    comment.topic_id = @topic.id   #コメントと投稿の関連付け
    comment.save
    flash[:notice] = "コメントの投稿に成功しました"
    render :comment
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    TopicComment.find_by(id: params[:id], topic_id: params[:topic_id]).destroy
     @topic_comment = TopicComment.new
    render :comment
  end

  # いいねしたコメントを取得
  def liked_comments
    @comments = TopicComment.joins(:likes).group('topic_comments.id')
  end

  private

  def topic_comment_params
    params.require(:topic_comment).permit(:comment)
  end

end
