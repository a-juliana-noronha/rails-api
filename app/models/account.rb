class Account < ApplicationRecord
  belongs_to :user
  belongs_to :cost_center, optional: true

  has_many :transactions
  has_many :cards
end
