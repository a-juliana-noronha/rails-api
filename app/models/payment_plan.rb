class PaymentPlan < ApplicationRecord
 belongs_to :user
 belongs_to :card

 has_many :transactions
end