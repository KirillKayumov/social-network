class PostDecorator < Draper::Decorator
  decorates_association :author
  decorates_association :owner

  delegate :avatar_url, :full_name, to: :author
  delegate :text

  def created_at
    l(object.created_at)
  end
end
