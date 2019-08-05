require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :gon_user, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_root_path : user_path(resource)
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user&.admin?
  end

  def gon_user
    gon.current_user_id = current_user ? current_user.id : 0
  end
end
