class CostCenter < ApplicationRecord
  belongs_to :user

  has_many :accounts
  has_many :cards
end
