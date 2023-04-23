class TopicComment < ApplicationRecord
  validates :comment, presence: true, length: { minimum: 2, maximum: 50 }

  belongs_to :user
  belongs_to :topic
  has_many :likes
end
