class LikesController < ApplicationController
  expose(:post)
  expose(:like, attributes: :like_params)

  def create
    like.save
    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  def destroy
    like = post.like_of(current_user)
    like.destroy
    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  private

  def like_params
    {
      likable_id: params[:post_id],
      likable_type: params[:likable_type],
      user_id: current_user.id
    }
  end
end
