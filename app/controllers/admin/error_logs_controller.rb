class Admin::ErrorLogsController < Admin::BaseController
  def index
    @logs = ErrorLog.includes(:user, :event).order(created_at: :desc)
  end

  def show
    @log = ErrorLog.find(params[:id])
  end
end
