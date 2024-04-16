class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :role, :status

  has_many :categories, if: -> { instance_options[:params]&.include? "categories" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
  has_many :accounts, if: -> { instance_options[:params]&.include? "accounts" }
  has_many :credit_cards, if: -> { instance_options[:params]&.include? "credit_cards" }
  has_many :goals, if: -> { instance_options[:params]&.include? "goals" }
end