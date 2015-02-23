class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender_id, :receiver_id, :text, presence: true

  scope :sent, -> { where(status: 'sent') }
  scope :read, -> { where(status: 'read') }
  scope :ordered, -> { order(created_at: :desc) }
end
