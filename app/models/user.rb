class User < ApplicationRecord

  has_secure_password

  VALID_EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :fullname, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20 },
            uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  # validates :profile_picture, presence: true

end
