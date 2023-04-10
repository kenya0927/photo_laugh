class TopicComment < ApplicationRecord

  belongs_to :user
  belongs_to :topic
  has_many :likes

end
