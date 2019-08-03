class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_root_path : user_path(resource)
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user&.admin?
  end
end
