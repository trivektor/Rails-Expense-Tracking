class Api::SessionsController < ApplicationController
  
  include Devise::Controllers::Helpers
  
  def create
    build_resource
    
    resource = User.find_for_database_authentication(:login => params[:user])
    
    if resource.nil?
      render :json => {:success => -1, :message => 'Username or password is incorrect'}
    end
    
    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render :json => {:success => 1, :auth_token => resource.authentication_token}
    else
      render :json => {:success => -1, :message => 'Username or password is incorrect'}
    end
  end
  
  def build_resource(hash = nil, options = {})
    hash ||= resource_params || {}

    if options[:unsafe]
      self.resource = resource_class.new.tap do |resource|
        hash.each do |key, value|
          setter = :"#{key}="
          resource.send(setter, value) if resource.respond_to?(setter)
        end
      end
    else
      self.resource = resource_class.new(hash)
    end
  end
  
  def resource_params
    params[resource_name]
  end
  
  def destroy
    user = User.find_by_authentication_token(params[:id])
    
    if user
      user.authentication_token = nil
      user.save
      sign_out user
      cookies.delete(:authentication_token)
    end
    
    render :text => :ok
  end
  
end
