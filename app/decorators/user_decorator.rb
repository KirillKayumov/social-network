class UserDecorator < Draper::Decorator
  SEXES = %i(male female)

  delegate :first_name,
           :last_name

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def birthday
    object.birthday.present? ? l(object.birthday) : I18n.t('not_specified')
  end

  def sex
    object.sex.present? ? I18n.t(object.sex) : I18n.t('not_specified')
  end

  def country
    object.country.present? ? object.country : I18n.t('not_specified')
  end

  def city
    object.city.present? ? object.city : I18n.t('not_specified')
  end

  def mobile
    object.mobile.present? ? object.mobile : I18n.t('not_specified')
  end

  def work_place
    object.work_place.present? ? object.work_place : I18n.t('not_specified')
  end

  def avatar_url(version = nil)
    if object.avatar?
      object.avatar_url(version)
    else
      '/without_avatar.gif'
    end
  end
end
