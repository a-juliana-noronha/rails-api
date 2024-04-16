class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :account_type, :color, :icon, :initial_amount, :status

  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
end