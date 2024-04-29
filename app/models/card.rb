class Card < ApplicationRecord
  belongs_to :user
  belongs_to :cost_center, optional: true
  belongs_to :account, optional: true

  has_many :transactions
  has_many :payment_plans
end
