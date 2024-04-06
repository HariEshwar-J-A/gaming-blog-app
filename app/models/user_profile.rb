class UserProfile < ApplicationRecord
  belongs_to :user

  # Validation examples
  validates :nickname, presence: true, uniqueness: true
  validates :bio, length: { maximum: 500 }
  # Add more validations as needed
end
