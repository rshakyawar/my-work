class User < ActiveRecord::Base
  has_one :profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def admin?
    true
  end

  def name
    "test user"
  end

  #blog_image_url (optional, the users photo, show next to comments/posts)
  #email (options - for gravatar support)


end
