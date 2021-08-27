class Authentication < ApplicationRecord
  # associations
  belongs_to :user

  # validations
  validates :user,
            uniqueness: { scope: :provider, message: 'and Provider combination already taken' }
end
