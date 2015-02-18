class UsersController < ApplicationController
  before_action :require_permission, except: :show

  expose(:user)
  expose(:decorated_user) { user.decorate }
  expose(:pending_friendships) { current_user.pending_friendships }
  expose(:posts) do
    user
    .wall_posts
    .order(created_at: :desc)
    .includes(:author)
  end
  expose(:decorated_posts) { posts.decorate }

  def update
    if update_user
      redirect_to edit_user_path(current_user), notice: t('messages.profile_updated')
    else
      render :edit
    end
  end

  protected

  def require_permission
    redirect_to current_user if user != current_user
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
    UserParams.new(params).params
  end
end
