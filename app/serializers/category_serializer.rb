class CategorySerializer < BaseSerializer
  attributes :id, :name, :description, :icon, :color, :status, :monthly_limit, :user_id
  
  belongs_to :user, if: -> { instance_options[:params]&.include? "user" }
  has_many :transactions, if: -> { instance_options[:params]&.include? "transactions" }
end