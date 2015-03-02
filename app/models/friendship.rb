class Friendship < ActiveRecord::Base
  extend Enumerize

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user_id, presence: true, uniqueness: { scope: :friend_id }
  validates :friend_id, presence: true
  validate :friendship_with_oneself
  validate :pending_request_from_friends

  scope :pending, -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }

  enumerize :status, in: %i(pending accepted), default: :pending, predicates: true

  def reversed
    Friendship.find_by(user_id: friend_id, friend_id: user_id)
  end

  protected

  def friendship_with_oneself
    errors.add(:base, 'Friendship With Oneself') if user_id == friend_id
  end

  def pending_request_from_friends
    errors.add(:base, 'Вам уже предложили дружбу') if Friendship.find_by(user_id: friend_id,
                                                                         friend_id: user_id,
                                                                         status: 'pending')
  end
end
