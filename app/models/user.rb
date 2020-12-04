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
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  # バリデーション
  validates :user_name,             presence: true,
                                    length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,                 presence: true,
                                    format: { with: VALID_EMAIL_REGEX }
  validates :password,              presence: true,
                                    length: { minimum: 6 }
  validates :password_confirmation, presence: true,
                                    length: { minimum: 6 }

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

  def added_shop?(shop_id)
    AddShop.where(shop_id: @shop.id).exists?
  end

  # ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # Active Storage 1つの画像を投稿
  has_one_attached :image

  # Active Storage バリデーション
  validate :image_type

  private

  def image_type
    if image.present? && !image.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:image,'にはjpeg,jpg,pngファイルを使用してください')
    end
  end
end
