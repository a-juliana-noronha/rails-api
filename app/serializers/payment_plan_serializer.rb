class PaymentPlanSerializer < BaseSerializer
  attributes :id, :total_amount, :total_installments, :days, :reminder, :status
  
  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :card, if: -> { instance_options[:params]&.include? "card" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
end