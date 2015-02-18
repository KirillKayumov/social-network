class ApplicationController < ActionController::Base
  protect_from_forgery

  expose(:friend_invitations_number) { current_user.pending_friendships.count }

  before_action :authenticate_user!

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
