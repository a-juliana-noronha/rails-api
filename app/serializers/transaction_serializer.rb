class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :name, :transaction_type, :amount, :date, :accrual_date, :reminder, :status

  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :category, if: -> { instance_options[:params]&.include? "category" }
  belongs_to :account, if: -> { instance_options[:params]&.include? "account" }
  belongs_to :credit_card, if: -> { instance_options[:params]&.include? "credit_card" }
end