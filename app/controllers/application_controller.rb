class ApplicationController < ActionController::Base
  protect_from_forgery

  expose(:friend_invitations_number) { current_user.friend_invitations_number }
  expose(:unread_messages_number) { current_user.unread_messages.count }

  before_action :authenticate_user!

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
