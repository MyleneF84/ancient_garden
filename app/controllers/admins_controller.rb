class AdminsController < ApplicationController
  layout "admins"
  before_action :authenticate_admin!
  def home
  end
end
