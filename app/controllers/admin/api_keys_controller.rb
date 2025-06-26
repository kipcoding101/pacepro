class Admin::ApiKeysController < Admin::BaseController
  def index
    @api_keys = current_user.api_keys.order(created_at: :desc)
  end

  def create
    @api_key = current_user.generate_api_key!
    flash[:notice] = "New API key: #{@api_key.token}"
    redirect_to admin_api_keys_path
  end

  def destroy
    @api_key = current_user.api_keys.find(params[:id])
    @api_key.update!(revoked: true)
    flash[:alert] = "API key revoked."
    redirect_to admin_api_keys_path
  end
end
