class User < ApplicationRecord
  # constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  # associations
  # has_many :tweets, dependent: :destroy
  # has_many :comments, dependent: :destroy

  # validations
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :name, presence: true
end
