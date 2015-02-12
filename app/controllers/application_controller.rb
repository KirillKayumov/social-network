class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
