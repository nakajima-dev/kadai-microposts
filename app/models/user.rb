class User < ApplicationRecord
  # 文字をすべて小文字に変換するもの
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  # 順方向の関係の構築
  has_many :relationships
  # 順方向の関係の構築を利用し、直接自分がフォローしているユーザを取得する。
  has_many :followings, through: :relationships, source: :follow
  # 逆方向の関係の構築（自分をフォローしている人はだれか）
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  # 逆方向の関係を利用し、直接自分をフォローしているユーザを取得する。
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  
  def follow(other_user)
    unless self == other_user
      # follow_idを指定している理由はselfがuserの立ち位置（自分がフォローする）なので、user_idではなくfollow_idを取得してくる
      self.relationships.find_or_create_by(follow_id: other_user.id)
      # 一度リロードしなければフォローされた側にその結果が反映されない。（データベース自体は更新。インスタンスが反映されていない。）
      # そのため演習では、インスタンスで確認するためにreloadをした。
      # 実際にはインスタンスを使いまわす時しか使用しないと考えていい？？
      self.reload
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # タイムラインの実装
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
end
