class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, :uniqueness => true
  validates :password, :length => { :minimum => 5 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  before_save :downcase_field

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.strip.downcase).authenticate(password)
  end

  def downcase_field
    self.email.downcase!
  end
end
