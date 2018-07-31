class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name

  #「使用者評論很多餐廳」的多對多關聯
  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  # 由於使用 restaurants 會和「使用者評論很多餐廳」重覆，將關聯名稱自訂為 :favorited_restaurants
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 「使用者追蹤使用者」的 self-referential relationships 設定
  # 不需要另加 source，Rails 可從 Followship Model 設定來判斷 followings 指向 User Model
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # Someone followed current_user
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user


  # Current_user friended someone
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Someone friended current_user
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :ivfriends, through: :inverse_friendships, source: :user


 # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def all_friends
    my_friends = self.friends
    ivfriends = self.ivfriends
    all_friends = (my_friends + ivfriends).uniq.sort
  end  

end
