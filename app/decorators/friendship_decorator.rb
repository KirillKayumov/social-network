class FriendshipDecorator < Draper::Decorator
  decorates_association :user
  decorates_association :friend

  delegate :full_name, to: :user, prefix: true
end
