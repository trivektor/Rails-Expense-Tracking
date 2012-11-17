class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_attached_file :image,
    :styles => {
      :medium => "300x300>",
      :thumb  => "100x100>"
    },
    :storage => :aws,
    :s3_credentials => {
      :access_key_id      => ENV['S3_ACCESS_KEY_ID'],
      :secret_access_key  => ENV['S3_SECRET_ACCESS_KEY']
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
  
  def as_json(options={})
    {
      :name             => self.name,
      :full_image_url   => self.image.url,
      :medium_image_url => self.image.url(:medium),
      :thumb_image_url  => self.image.url(:thumb),
      :description      => self.description,
      :created_at       => self.created_at.in_time_zone('Pacific Time (US & Canada)').strftime("%d/%m/%Y %H:%M%P"),
    }
  end
  
end
