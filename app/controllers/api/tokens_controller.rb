class Api::TokensController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  # Copied from http://matteomelani.wordpress.com/2011/10/17/authentication-for-mobile-devices/
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    
    if email.blank? or password.blank?
      render :json => {:success => -1, :errors => "Email and password cannot be blank"}
    end
    
    @user = User.find_by_email(email.downcase)
    
    if @user.nil?
      render :json => {:success => -1, :errors => "No user with the provided email was found"} and return
    end
    
    @user.ensure_authentication_token!
    
    if !@user.valid_password?(password)
      render :json => {:success => -1, :errors => "Invalid password"}
    else
      render :json => {:success => 1, :message => "You have successfully signed in", :token => @user.authentication_token}
    end
  end
  
  def validate
    token = params[:user][:token]
    
    @user = User.find_by_authentication_token(token)
    
    if @user.nil?
      render :json => {:success => -1, :errors => "Please login before proceeding"} and return
    end
    
    render :json => {:success => 1}
  end
  
end
