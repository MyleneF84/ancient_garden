class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  layout :set_layout
  helper_method :current_namespace

  def after_sign_in_path_for(resource)
    if resource.admin?
      admins_root_path
    else
      root_path
    end
  end

  private

  def set_layout
    current_user&.admin? ? "admins" : "application"
  end

  def current_namespace
    current_user&.admin? ? "admins" : "public"
  end
end
