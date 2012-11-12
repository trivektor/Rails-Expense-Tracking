class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :token_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible  :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :authentication_token
  # attr_accessible :title, :body
  
  has_many :expenses
  has_many :receipts
  
  def self.find_for_database_authentication(conditions={})
    #self.where("username = ?", conditions[:email]).limit(1).first ||
    self.where("email = ?", conditions[:email]).limit(1).first
  end
end
