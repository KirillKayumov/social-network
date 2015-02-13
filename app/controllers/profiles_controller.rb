class ProfilesController < ApplicationController
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
end
