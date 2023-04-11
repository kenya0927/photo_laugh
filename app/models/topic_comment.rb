class TopicComment < ApplicationRecord

  validates :topic_comment, presence: true

  belongs_to :user
  belongs_to :topic
  has_many :likes

end
