class User < ApplicationRecord
  has_secure_password

  enum :role, { user: "user", admin: "admin"}

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :role, presence: true, inclusion: { in: ["user", "admin"] }

end