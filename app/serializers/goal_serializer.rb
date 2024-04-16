class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :due_date, :icon, :color, :status

  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
end