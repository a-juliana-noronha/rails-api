class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :account, optional: true
  belongs_to :card, optional: true
  belongs_to :goal, optional: true
  belongs_to :payment_plan, optional: true

  attr_accessor :has_payment_plan

  def has_payment_plan
    !!self.payment_plan_id
  end
end
