class Api::ReceiptsController < ApplicationController
  
  before_filter :find_user
  
  def create
    receipt = Receipt.new(params[:receipt])
    receipt.user_id = @user.id
    if receipt.save
      render :json => {:success => 1, :message => 'Receipt saved successfully'}
    else
      render :json => {:success => -1, :message => 'An error occurred'}
    end
  end
  
  private
  
  def find_user
    @user = User.find_by_authentication_token(params[:token])
  end
  
end
