class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image
  has_attached_file :image
  
  before_save do
    self.name = 'Expense' if self.name.blank?
  end
  
end
