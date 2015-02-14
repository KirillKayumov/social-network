class Friendship < ActiveRecord::Base
  STATUSES = ['pending', 'accepted']

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user_id, uniqueness: { scope: :friend_id }
  validates :status, inclusion: { in: STATUSES }

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
end
