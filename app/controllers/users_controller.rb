class UsersController < ApplicationController
  expose(:user)
  expose(:decorated_user) { user.decorate }
  expose(:posts) { user.wall_posts.reversed.includes(:author) }
  expose(:decorated_posts) { posts.decorate }

  def show
  end
end
