class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  expose(:friendship)
  expose(:profile) { Profile.find(params[:profile_id]) }
  expose(:friends) { profile.user.accepted_friends }
  expose(:decorated_friends) { friends.decorate }

  def index
  end

  def create
    friendship.update(friendship_params)
    redirect_to profile_path(friendship.friend.profile)
  end

  def accept
    friendship.update(status: 'accepted')
    Friendship.create(
      user_id: current_user.id,
      friend_id: friendship.user_id,
      status: 'accepted'
    )
    redirect_to profile_path(current_user.profile)
  end

  def reject
    friendship.destroy
    redirect_to profile_path(current_user.profile)
  end

  def destroy
    friendship.destroy
    friendship.reversed.destroy
    redirect_to profile_path(friendship.friend.profile)
  end

  private

  def friendship_params
    params.require(:friendship).permit(
      :friend_id
    ).merge(
      user_id: current_user.id
    )
  end
end
