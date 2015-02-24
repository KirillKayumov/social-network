class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  mount_uploader :avatar, AvatarUploader

  delegate :url, to: :avatar, prefix: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, class_name: :Post, foreign_key: :author_id
  has_many :wall_posts, class_name: :Post, foreign_key: :owner_id, dependent: :destroy
  has_many :likes
  has_many :photos, dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  validates :first_name, :last_name, presence: true
  validates :mobile, format: { with: /\A(\+\d{1,3}[- ]?)?\d{10}\z/ }, allow_nil: true

  def unread_messages
    received_messages.sent
  end

  def accepted_friends
    User.joins(:friendships).where(friendships: { friend_id: id, status: 'accepted' })
  end

  def pending_friends
    User.joins(:friendships).where(friendships: { friend_id: id, status: 'pending' })
  end

  def pending_friendships
    Friendship.pending.where(friend_id: id)
  end

  def friendship_with(user)
    friendships.find_by(friend_id: user.id)
  end
end
