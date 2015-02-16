class UserDecorator < Draper::Decorator
  SEXES = [:male, :female]

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def avatar_url(version)
    if object.avatar?
      object.avatar_url(version)
    else
      '/without_avatar.gif'
    end
  end
end
