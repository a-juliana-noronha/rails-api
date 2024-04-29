class CostCenterSerializer < BaseSerializer
  attributes :id, :name, :description, :color, :icon, :status

  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }

  has_many :accounts, if: -> { instance_options[:params]&.include? "accounts" }
  has_many :cards, if: -> { instance_options[:params]&.include? "cards" }
end