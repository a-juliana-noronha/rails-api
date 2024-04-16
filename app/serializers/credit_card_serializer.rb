class CreditCardSerializer < BaseSerializer
  attributes :id, :name, :issuer, :icon, :color, :limit, :closing_date, :due_date, :status
  
  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :account, if: -> { instance_options[:params]&.include? "account" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
end