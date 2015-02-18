class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate_user!

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
