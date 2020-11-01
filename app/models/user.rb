class User < ApplicationRecord
  has_many :lists, dependent: :destroy

  # AddShop
  has_many :AddShop
  has_many :shops, through: :AddShop

  # following
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy   
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  # ユーザー検索
  def User.search(search, user_or_list_or_shop)
    if user_or_list_or_shop == "1"
       User.where(['user_name LIKE ?', "%#{search}%"])
    else
       User.all
    end
  end

  # 画像アップロード
  mount_uploader :image, ImageUploader

  def added_shop?(user)
    shops.exists?
  end
  
end
