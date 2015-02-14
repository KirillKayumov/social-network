class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_one :profile, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  after_create :create_profile

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
    friendships.accepted.find_by(friend_id: user.id)
  end
end
