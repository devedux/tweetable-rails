class Tweet < ApplicationRecord
  # associations
  belongs_to :user
  # has_many :comments, counter_cache: true

  # validations
  validates :body, presence: true
  validates :body, length: { maximum: 140 }
end
