class Friendship < ActiveRecord::Base
  STATUSES = %w(pending accepted)

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user_id, presence: true, uniqueness: { scope: :friend_id }
  validates :status, inclusion: { in: STATUSES }
  validates :friend_id, presence: true
  validate :friendship_with_oneself
  validate :pending_request_from_friends

  scope :pending, -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }

  def reversed
    Friendship.find_by(user_id: friend_id, friend_id: user_id)
  end

  def pending?
    status == 'pending'
  end

  def accepted?
    status == 'accepted'
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
