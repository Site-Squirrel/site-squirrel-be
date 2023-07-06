class User < ApplicationRecord
  has_secure_password

  has_many :trips, dependent: :destroy
  has_many :reservation_days, through: :trips

  validates :name, :email, :password_digest, :phone, presence: true
  validates :email, :phone, uniqueness: true
end
