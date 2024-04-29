class Reminder < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :account, optional: true

  has_many :transactions

  attr_accessor :paid
end
