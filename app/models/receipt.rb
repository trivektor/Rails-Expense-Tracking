class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_attached_file :image,
    :storage => :aws,
    :s3_credentials => {
      :access_key_id => 'AKIAIGHKJHBKXPQHPWIQ',
      :secret_access_key => '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'
    },
    :s3_acl => :public_read,
    :s3_protocol => 'http',
    :s3_bucket => :dom305,
    :path => "images/:id/:style/:filename"
    
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
