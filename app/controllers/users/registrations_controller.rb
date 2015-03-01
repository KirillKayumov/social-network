module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: :create
    before_action :configure_update_params, only: :update

    expose(:decorated_resource) { resource.decorate }

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation
        )
      end
    end

    def update_resource(resource, params)
      if params[:email] || params[:password]
        resource.update_with_password(params)
      else
        resource.update_without_password(params)
      end
    end

    def configure_update_params
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(user_attributes)
      end
    end

    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_update_path_for(resource)
      edit_registration_path(resource)
    end

    private

    def user_attributes
      %i(
        avatar avatar_cache remove_avatar first_name last_name sex birthday
        country city work_place mobile email current_password password
        password_confirmation
      )
    end
  end
end
