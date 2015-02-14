class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  protected

  def after_sign_in_path_for(resource)
    profile_path(resource.profile)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
