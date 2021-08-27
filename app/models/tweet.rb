class Tweet < ApplicationRecord
  # associations
  belongs_to :user

  has_many :comments, dependent: :destroy

  # validations
  validates :body, presence: true
  validates :body, length: { maximum: 140 }
end
