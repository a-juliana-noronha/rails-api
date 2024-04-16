class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :category, optional: true
  belongs_to :goal, optional: true
end
