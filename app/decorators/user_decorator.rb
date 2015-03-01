class UserDecorator < Draper::Decorator
  PROFILE_ATTRIBUTES = %i(
    sex
    birthday
    country
    city
    work_place
    mobile
  )

  delegate :first_name,
           :last_name,
           :country,
           :city,
           :mobile,
           :work_place

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def formatted_attribute(attr_name)
    object.send(attr_name).present? ? send(attr_name) : I18n.t('not_specified')
  end

  def birthday
    l(object.birthday)
  end

  def sex
    object.sex.text
  end

  def avatar_url(version = nil)
    if object.avatar?
      object.avatar_url(version)
    else
      '/without_avatar.gif'
    end
  end
end
