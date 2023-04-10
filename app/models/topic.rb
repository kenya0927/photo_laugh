class Topic < ApplicationRecord

    has_one_attached :image

    belongs_to :user
    has_many :topic_comments,dependent: :destroy
    has_many :likes

end
