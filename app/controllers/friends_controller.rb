class FriendsController < ApplicationController
  expose(:user)
  expose(:decorated_friends) { user.friends.decorate }
  expose(:decorated_pending_friends) { user.pending_friends.decorate }
  expose(:friendship) do
    Friendship.find_by(user_id: params[:id], friend_id: params[:user_id])
  end
  expose(:people) { User.where.not(id: user.friends).where.not(id: user.id).ordered }
  expose(:decorated_people) { people.decorate }

  def index
    respond_to do |format|
      format.html {}
      format.js { render 'index', locals: { section: params[:section] } }
    end
  end

  def create
    friendship = Friendship.create(
      user_id: params[:user_id],
      friend_id: params[:friend][:id]
    )

    respond_to do |format|
      format.js { render 'create', locals: { friend_id: friendship.friend_id } }
    end
  end

  def accept
    friendship.update(status: 'accepted')
    Friendship.create(
      user_id: friendship.friend_id,
      friend_id: friendship.user_id,
      status: 'accepted'
    )

    respond_to do |format|
      format.js { render 'accept', locals: { friend_id: friendship.user_id } }
    end
  end

  def reject
    friendship.destroy

    respond_to do |format|
      format.js { render 'reject', locals: { friend_id: friendship.user_id } }
    end
  end

  def destroy
    friendship.destroy
    friendship.reversed.destroy

    respond_to do |format|
      format.js { render 'destroy', locals: { friend_id: friendship.user_id } }
    end
  end
end
