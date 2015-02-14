class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate_user!
  before_action :completed_profile?

  protected

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def completed_profile?
    if user_signed_in? && current_user.profile.pending?
      redirect_to edit_profile_path(current_user.profile), alert: t('messages.pending_profile')
    end
  end
end
