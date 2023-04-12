class TopicComment < ApplicationRecord

  validates :comment, presence: true,length: { maximum: 50 }

  belongs_to :user
  belongs_to :topic
  has_many :likes

end
