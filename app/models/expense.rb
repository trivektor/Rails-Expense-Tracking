class Expense < ActiveRecord::Base
  attr_accessible :user_id, :name, :amount, :tax, :tip, :category, :description, :originally_created_at
  
  validates_presence_of :name
  validates :amount, :numericality => {:only_integer => false}
  
end
