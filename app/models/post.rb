class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :content, presence: true

  # Logic to handle comma-separated category names
  def category_names=(names)
    self.categories = names.split(',').map do |n|
      Category.where(name: n.strip).first_or_create!
    end
  end

  def category_names
    self.categories.map(&:name).join(', ')
  end
end
