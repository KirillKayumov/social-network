class UsersController < ApplicationController
  respond_to :html, :js

  expose(:user) { User.find(params[:id]) }
  expose(:decorated_user) { user.decorate }
  expose(:decorated_posts) { user.wall_posts.includes(:author).decorate }
  expose(:users) { current_user.not_friends.ordered }
  expose(:decorated_users) { users.decorate }

  def index
    respond_with users
  end

  def show
    respond_with user
  end
end
