class DashboardController < ApplicationController
  before_action :redirect_if_signed_in

  def index
  end

  private

  def redirect_if_signed_in
    redirect_to current_user.profile if current_user
  end
end
