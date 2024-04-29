class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { message: "já cadastrado" }
  validates :password_digest,
            length: { minimum: 4 },
            if: -> { new_record? || !password_digest.nil? }

  has_many :categories
  has_many :transactions
  has_many :cost_centers
  has_many :accounts
  has_many :cards
  has_many :goals
end
