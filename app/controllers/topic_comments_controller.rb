class TopicCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @topic = Topic.find(params[:topic_id])
    @topic_comment = current_user.topic_comments.new(topic_comment_params)   #ログインしているユーザーによって作成されたコメントの生成
    @topic_comment.topic_id = @topic.id   #コメントと投稿の関連付け
    if @topic_comment.save
       @topic_comment = TopicComment.new   # フォームのデータを空にする
      render :comment
    else
      render :error
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    TopicComment.find_by(id: params[:id], topic_id: params[:topic_id]).destroy
    @topic_comment = TopicComment.new
    render :comment
  end

  # いいねしたコメントを取得
  def liked_comments
    @comments = TopicComment.joins(:likes).where(likes: { user_id: current_user.id }).group('topic_comments.id')
  end


  private

  def topic_comment_params
    params.require(:topic_comment).permit(:comment)
  end

end
