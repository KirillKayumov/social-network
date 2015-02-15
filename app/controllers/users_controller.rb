class UsersController < ApplicationController
  def update
    if update_user
      redirect_to edit_user_path(current_user), notice: t('messages.profile_updated')
    else
      render :edit
    end
  end

  private

  def update_user
    if user_params[:current_password]
      current_user.update_with_password(user_params)
    else
      current_user.update(user_params)
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :sex,
      :birthday,
      :country,
      :city,
      :mobile,
      :email,
      :current_password,
      :password,
      :password_confirmation
    )
  end
end
