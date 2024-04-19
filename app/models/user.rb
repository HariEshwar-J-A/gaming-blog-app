class User < ApplicationRecord
  # Devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Consider adding validations for custom fields you might have added to the User model
  def generate_jwt
    JWT.encode({ id: id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.jwt_secret_key)
  end
end
