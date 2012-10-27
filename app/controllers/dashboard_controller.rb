class DashboardController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    # Revisit
    unless cookies[:auth_token]
      current_user.ensure_authentication_token!
      cookies[:auth_token] = current_user.authentication_token
    end
  end
  
end
