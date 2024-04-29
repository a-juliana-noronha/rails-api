class CardSerializer < BaseSerializer
  attributes :id, :name, :issuer, :icon, :color, :limit, :closing_day, :due_day, :is_default, :status
  
  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :account, if: -> { instance_options[:params]&.include? "account" }
  belongs_to :cost_center, if: -> { instance_options[:params]&.include? "cost_center" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
  has_many :payment_plans, if: -> { instance_options[:params]&.include? "payment_plans" }
end