class ApplicationController < ActionController::Base
  before_action :authenticate_admin!

  # def after_sign_in_path_for(resource)
  #   if resource.is_a?(Admin)
  #     admins_root_path
  #   else
  #     root_path
  #   end
  # end
end
