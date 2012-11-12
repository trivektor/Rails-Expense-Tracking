class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image
  has_attached_file :image
  
  scope :latest_first, order('created_at DESC')
  
  before_save do
    self.name = 'Expense' if self.name.blank?
  end
  
end
