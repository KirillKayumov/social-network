class DashboardController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_signed_in

  def index
  end

  private

  def redirect_if_signed_in
    redirect_to current_user.profile if user_signed_in?
  end
end
