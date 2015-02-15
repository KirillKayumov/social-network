class UserDecorator < Draper::Decorator
  SEXES = [:male, :female]

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
