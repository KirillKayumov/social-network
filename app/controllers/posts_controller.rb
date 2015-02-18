class PostsController < ApplicationController
  before_action :require_permission, only: [:destroy]

  expose(:post, attributes: :post_params)

  def create
    post.save
    redirect_to post.owner
  end

  def destroy
    post.destroy
    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  protected

  def require_permission
    redirect_to post.owner if post.author != current_user
  end

  private

  def post_params
    params.require(:post).permit(
      :owner_id,
      :text
    ).merge(
      author_id: current_user.id
    )
  end
end
