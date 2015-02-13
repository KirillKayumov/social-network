class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :completed_profile?

  protected

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def completed_profile?
    if current_user && !current_user.profile.completed?
      redirect_to edit_profile_path(current_user.profile)
    end
  end
end
