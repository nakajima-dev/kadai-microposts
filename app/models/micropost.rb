class Micropost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
  
  # ここはmicropostsのモデルなので勝手にidをモデルにしてくれる
  has_many :favorites
  has_many :fav_user, through: :favorites, source: :user
end
