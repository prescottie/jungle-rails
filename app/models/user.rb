class User < ActiveRecord::Base
  validates :email, :uniqueness => {:case_sensitive => false}, presence: true
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true, length: {minimum: 6}
  validates :first_name, presence: true
  validates :last_name, presence: true

  
  has_secure_password
  has_many :reviews

  def self.authenticate_with_credentials(email, password)
    user = where("LOWER(email) = ?", email.downcase.strip)[0]
    if user && user.authenticate(password)
      return user
    else 
      return nil
    end
  end
end