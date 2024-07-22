# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('LOWER(email) = ?', email.strip.downcase)
    user && user.authenticate(password) ? user : nil
  end
end
