class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_attached_file :image,
    :storage => :aws,
    :s3_credentials => {
      :access_key_id => ENV['S3_ACCESS_KEY_ID'],
      :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
    },
    :s3_acl => :public_read,
    :s3_protocol => 'http',
    :s3_bucket => :expense_tracker,
    :path => "receipts/:id/:style/:filename"
    
  attr_accessible :name,
                  :description,
                  :image  
  
  scope :latest_first, order('created_at DESC')
  
  before_save do
    self.name = 'Receipt' if self.name.blank?
  end
  
end
