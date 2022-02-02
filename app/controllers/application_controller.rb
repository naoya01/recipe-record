class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top,:usage]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      meals_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        # 情報更新時にnicknameの取得を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
