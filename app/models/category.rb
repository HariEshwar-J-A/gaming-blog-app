class Category < ApplicationRecord
  has_and_belongs_to_many :posts

  # validates :name, presence: true, uniqueness: { case_sensitive: false }
  # The 'dependent: :nullify' option will nullify the category_id on posts when a category is deleted,
  # preventing orphaned posts. Adjust based on your application's requirements.
end
