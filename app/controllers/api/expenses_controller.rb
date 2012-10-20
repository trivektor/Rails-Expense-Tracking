class Api::ExpensesController < ApplicationController
  
  before_filter :find_user
  
  def index
    respond_to do |format|
      format.json { render :json => Expense.all }
    end
  end
  
  def create
    expense = Expense.new(params[:expense].merge({:user_id => @user.id}))
    if expense.save
      render :json => {:success => 1, :message => 'Expense has been saved'}
    else
      render :json => {:success => -1, :errors => expense.errors.full_messages.join(". ")}
    end
  end
  
  private
  
  def find_user
    @user = User.find_by_authentication_token(params[:token])
  end
  
end
