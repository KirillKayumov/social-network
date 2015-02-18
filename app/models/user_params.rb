class UserParams
  attr_reader :params

  PARAMS = %i(
    avatar
    avatar_cache
    remove_avatar
    first_name
    last_name
    sex
    birthday
    country
    city
    work_place
    mobile
    email
    current_password
    password
    password_confirmation
  )

  def initialize(params)
    @params = params.require(:user).permit(*PARAMS)
  end
end
