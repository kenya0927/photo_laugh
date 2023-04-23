class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true


  has_many :topics, dependent: :destroy
  has_many :topic_comments, dependent: :destroy
  has_many :likes

  # ゲストユーザー機能
  def self.guest
    find_or_create_by!(name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64  # ランダムな文字列の生成
      user.name = "guestuser"
    end
  end
end
