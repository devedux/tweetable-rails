require 'open-uri'

class User < ApplicationRecord
  # constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  # associations
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authentications, dependent: :destroy

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
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2 facebook]

  def self.from_omniauth(auth)
    authentication = Authentication.where(provider: auth.provider,
                                          uid: auth.uid).first_or_initialize

    unless authentication.user
      user = find_by(email: auth.info.email)
      user ||= create_user(auth.info)
      authentication.user = user
      authentication.save
    end
    authentication.user
  end

  def self.create_user(info)
    user = User.new
    user.complete_attributes(info)
    user.avatar_attach(info)
    user.save
    user
  end

  def complete_attributes(info)
    self.username = info.nickname || info.name
    self.name = info.first_name || info.name
    self.email = info.email
    self.password = Devise.friendly_token[0, 20]
  end

  def avatar_attach(info)
    download_image = URI.parse(info.image).open
    avatar.attach(io: download_image, filename: "#{info.nickname || info.name}-avatar")
  end
end
