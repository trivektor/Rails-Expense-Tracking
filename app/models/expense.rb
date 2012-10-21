class Expense < ActiveRecord::Base
  attr_accessible :user_id, :name, :amount, :tax, :tip, :category, :description, :originally_created_at
  
  validates_presence_of :name
  validates :amount, :numericality => {:only_integer => false}
  
  scope :latest_first, order('created_at DESC')
  
  def as_json(options={})
    {
      :id => self.id,
      :name => self.name,
      :amount => self.amount.to_f,
      :created_at => self.created_at.in_time_zone('Pacific Time (US & Canada)').strftime("%d/%m/%Y %H:%M%P"),
      :description => self.description || ""
    }
  end
  
end
