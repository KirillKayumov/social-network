class FriendshipsController < ApplicationController
  before_action :require_permission, only: %i(accept reject)
  before_action :require_permission2, only: :destroy

  expose(:user)
  expose(:friendship)
  expose(:friends) { user.accepted_friends.order(first_name: :asc) }
  expose(:decorated_friends) { friends.decorate }
  expose(:pending_friendships) do
    user
    .pending_friendships
    .order(created_at: :desc)
    .includes(:user)
  end
  expose(:people) { User.where.not(id: current_user.friends).where.not(id: current_user.id) }

  def index
  end

  def create
    friendship = Friendship.new(friendship_params)
    if friendship.save
      redirect_to user_friends_path(current_user), notice: t('messages.invitation_sent')
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

    redirect_to user_friends_path(current_user), notice: t('messages.accept_friend')
  end

  def reject
    friendship.destroy

    redirect_to user_friends_path(current_user), notice: t('messages.reject_friend')
  end

  def destroy
    friendship.destroy
    friendship.reversed.destroy

    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  protected

  def require_permission
    redirect_to current_user if friendship.friend != current_user
  end

  def require_permission2
    redirect_to current_user if friendship.user != current_user
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
