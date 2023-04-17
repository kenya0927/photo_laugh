class TopicCommentsController < ApplicationController

  before_action :authenticate_user!,only:[:destroy]

  def create
    topic = Topic.find(params[:topic_id])
    comment = current_user.topic_comments.new(topic_comment_params)   #ログインしているユーザーによって作成されたコメントの生成
    comment.topic_id = topic.id   #コメントと投稿の関連付け
   if comment.save
    flash[:notice] = "コメントの投稿に成功しました"
    redirect_to topic_path(topic)
   else
    @topic = Topic.find(params[:topic_id])
    @topic_comment = TopicComment.new
    render 'topics/show'
   end
  end

  def destroy
    TopicComment.find(params[:id]).destroy
    redirect_to topic_path(params[:topic_id])
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
