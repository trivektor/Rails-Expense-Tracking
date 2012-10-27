class DashboardController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    # Revisit
    current_user.ensure_authentication_token!
    cookies[:auth_token] = {
      :value    => current_user.authentication_token,
      :expires  => 30.days.from_now
    }
  end
  
end
