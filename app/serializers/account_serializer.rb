class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :account_type, :color, :icon, :is_default, :status

  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  belongs_to :cost_center, if: -> { instance_options[:params]&.include? "cost_center" }

  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
  has_many :cards, if: -> { instance_options[:params]&.include? "cards" }
end