class ReminderSerializer < BaseSerializer
  attributes :id, :name, :transaction_type, :amount, :due_day, :status, :account_id, :category_id, :paid
  
  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :account, if: -> { instance_options[:params]&.include? "account" }
  belongs_to :category, if: -> { instance_options[:params]&.include? "category" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
end