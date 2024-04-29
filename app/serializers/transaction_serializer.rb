class TransactionSerializer < BaseSerializer
  attributes :id, :name, :transaction_type, :amount, :date, :current_installment, :status, :paid, :account_id, :card_id, :category_id, :reminder_id, :payment_plan_id, :has_payment_plan

  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :category, if: -> { instance_options[:params]&.include? "category" }
  belongs_to :account, if: -> { instance_options[:params]&.include? "account" }
  belongs_to :card, if: -> { instance_options[:params]&.include? "card" }
  belongs_to :reminder, if: -> { instance_options[:params]&.include? "reminder" }
  belongs_to :payment_plan, if: -> { instance_options[:params]&.include? "payment_plan" }
end