class Like < ApplicationRecord

  belongs_to :user
  belongs_to :topic
  belongs_to :topic_comment

  validates_uniqueness_of :comment_id, scope: :user_id

end
