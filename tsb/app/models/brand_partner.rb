class BrandPartner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:partner_name]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :partner_name

  has_many :versuses, :dependent=> :destroy, :class_name=>'Versus'
  
  validates_uniqueness_of :email, :partner_name 
  validates_presence_of  :email, :partner_name ,:password

end
