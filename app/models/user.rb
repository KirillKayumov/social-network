class User < ActiveRecord::Base
  extend Enumerize

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  mount_uploader :avatar, AvatarUploader

  delegate :url, to: :avatar, prefix: true

  has_many :friends, -> { where(friendships: { status: 'accepted' }) }, through: :friendships
  has_many :friendships, dependent: :destroy
  has_many :posts, class_name: :Post, foreign_key: :author_id
  has_many :wall_posts, -> { ordered }, class_name: :Post, foreign_key: :owner_id, dependent: :destroy
  has_many :likes
  has_many :photos, dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  validates :first_name, :last_name, presence: true
  validates :mobile, format: { with: /\A((\+\d{1,3}[- ]?)|8)?\d{10}\z/ }, allow_blank: true

  scope :ordered, -> { order(first_name: :asc, last_name: :asc) }

  enumerize :sex, in: %i(male female)

  def not_friends
    User.where.not(id: friends.pluck(:id).push(id))
  end

  def friend_of?(user)
    friendship_with(user).accepted?
  end

  def pending_friend_of?(user)
    friendship_with(user).pending?
  end

  def friendship_with(user)
    friendships.find_by(friend_id: user.id) || Null::Friendship.new
  end

  def friend_invitations_number
    Friendship.pending.where(friend_id: id).count
  end

  def pending_friends
    User.joins(:friendships).where(friendships: { friend_id: id, status: 'pending' })
  end

  def unread_messages
    received_messages.sent
  end

  # def pending_friendships
  #   Friendship.pending.where(friend_id: id)
  # end
end
