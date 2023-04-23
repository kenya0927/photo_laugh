class Like < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :topic_comment

  # ログインしているユーザーが1つのコメントに対して1度しかいいねできないようする
  validates_uniqueness_of :topic_comment_id, scope: :user_id
end
