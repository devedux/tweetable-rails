class User < ApplicationRecord
  # constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  # associations
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar

  # validations
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
