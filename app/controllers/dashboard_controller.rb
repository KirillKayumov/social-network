class DashboardController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_signed_in

  expose(:users_number) { User.count }

  def index
  end

  private

  def redirect_if_signed_in
    redirect_to current_user if user_signed_in?
  end
end
