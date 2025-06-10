class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :verify_admin

  private

  def verify_admin
    return if current_user.admin?

    redirect_to root_path, 
      alert: "You must be an admin to access this section."
  end
end