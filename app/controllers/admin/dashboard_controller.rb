class Admin::DashboardController < Admin::BaseController
  def index
    @users = User.all
    # Add any other admin stats you want to display
  end
end