class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_attached_file :image
  attr_accessible :name,
                  :description,
                  :image_file_name, 
                  :image_content_type, 
                  :image_file_size, 
                  :image_updated_at
  
  
  scope :latest_first, order('created_at DESC')
  
  before_save do
    self.name = 'Receipt' if self.name.blank?
  end
  
end
