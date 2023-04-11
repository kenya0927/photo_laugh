class Topic < ApplicationRecord

    has_one_attached :image

    validates :title, presence: true,length: { maximum: 30 }
    validates :image, presence: true

    belongs_to :user
    has_many :topic_comments,dependent: :destroy
    has_many :likes

end
