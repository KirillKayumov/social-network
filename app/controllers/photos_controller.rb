class PhotosController < ApplicationController
  expose(:user)
  expose(:photos, ancestor: :user)
  expose(:photo, attributes: :photo_params)

  def index
  end

  def create
    photo.save
    redirect_to user_photos_path(current_user), notice: t('messages.photo_uploaded')
  end

  def destroy
    photo.destroy
    redirect_to user_photos_path(current_user), notice: t('messages.photo_removed')
  end

  private

  def photo_params
    params.require(:photo).permit(
      :image
    )
  end
end
