class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books
  has_many :book_comments,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :group_users
  has_many :groups, through: :group_users

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end


  def User.search(search, user_or_book, how_search)
    if how_search == "1"
       User.where(['name LIKE ?', "%#{search}%"])
       elsif how_search == "2"
       User.where(['name LIKE ?', "%#{search}"])
       elsif how_search == "3"
       User.where(['name LIKE ?', "#{search}%"])
       elsif how_search == "4"
       User.where(['name LIKE ?', "#{search}"])
    else
       User.all
    end
  end



  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
