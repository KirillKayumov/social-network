class UserDecorator < Draper::Decorator
  delegate :profile, to: :user

  def full_name
    "#{profile.first_name} #{profile.last_name}"
  end
end
