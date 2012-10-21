class Api::ExpensesController < ApplicationController
  
  before_filter :find_user
  before_filter :find_expense, :only => [:show, :destroy]
  
  def index
    render :json => {:expenses => @user.expenses.latest_first}
  end
  
  def create
    expense = Expense.new(params[:expense].merge({:user_id => @user.id}))
    if expense.save
      render :json => {:success => 1, :message => 'Expense has been saved'}
    else
      render :json => {:success => -1, :errors => expense.errors.full_messages.join(". ")}
    end
  end
  
  def show
    render :json => {:expense => @expense}
  end
  
  def destroy
    if @expense.destroy
      render :json => {:success => 1, :message => 'Expense has been deleted'}
    else
      render :json => {:success => -1, :message => 'An error has occurred'}
    end
  end
  
  private
  
  def find_user
    @user = User.find_by_authentication_token(params[:token])
  end
  
  def find_expense
    @expense = @user.expenses.find(params[:id])
  end
  
end
