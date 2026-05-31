class User < ApplicationRecord
  has_secure_password

  enum :role, { user: "user", admin: "admin"}

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

end