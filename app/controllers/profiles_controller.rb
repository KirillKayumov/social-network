class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :require_permission, only: [:edit, :update]
  skip_before_action :completed_profile?, only: [:edit, :update]

  expose(:profile, attributes: :profile_params)

  def show
  end

  def edit
  end

  def update
    if profile.save
      redirect_to profile_path(profile)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :first_name,
      :last_name,
      :sex,
      :birthday,
      :country,
      :city,
      :mobile
    )
  end

  def require_permission
    redirect_to profile_path(current_user.profile) if profile.user != current_user
  end
end
