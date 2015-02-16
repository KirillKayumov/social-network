class FriendshipsController < ApplicationController
  expose(:user)
  expose(:friendship, attributes: :friendship_params)
  expose(:friends) { user.accepted_friends.order(first_name: :asc) }
  expose(:decorated_friends) { friends.decorate }

  def index
  end

  def create
    if friendship.save
      redirect_to friendship.friend, notice: t('messages.invitation_sent')
    else
      redirect_to friendship.friend, alert: t('messages.already_friends')
    end
  end

  def accept
    friendship.update(status: 'accepted')
    Friendship.create(
      user_id: current_user.id,
      friend_id: friendship.user_id,
      status: 'accepted'
    )
    redirect_to current_user
  end

  def reject
    friendship.destroy
    redirect_to current_user
  end

  def destroy
    friendship.destroy
    friendship.reversed.destroy
    redirect_to user_friends_path(current_user), notice: t('messages.friend_removed')
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
