class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :require_permission, only: [:edit, :update]

  expose(:profile, attributes: :profile_params)
  expose(:pending_friendships) { current_user.pending_friendships }
  expose(:decorated_pending_friendships) { pending_friendships.decorate }
  expose(:friendship) do
    Friendship.find_by(user_id: current_user.id, friend_id: profile.user.id) || Nil::Friendship.new
  end
  expose(:posts) { profile.posts }

  def show
  end

  def edit
  end

  def update
    if profile.save
      redirect_to edit_profile_path(profile), notice: t('messages.profile_updated')
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
    redirect_to current_user if profile.user != current_user
  end
end
