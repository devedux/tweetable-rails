class Comment < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  # validations
  validates :body, presence: true
  validates :body, length: { maximum: 140 }
end
